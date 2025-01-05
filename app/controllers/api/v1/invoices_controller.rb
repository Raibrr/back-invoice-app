class Api::V1::InvoicesController < ApplicationController
  def index

    unless params[:start_date].present? && params[:end_date].present?
      return render json: { 
        success: false, 
        error: 'start_date y end_date son requeridos' 
      }, status: :unprocessable_entity
    end

    start_date = DateTime.parse(params[:start_date])
    end_date = DateTime.parse(params[:end_date])

    cache_key = "invoices_#{params[:start_date]}_#{params[:end_date]}"

    Rails.logger.info(cache_key)

    # Intentar obtener las facturas desde el caché
    invoices = Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      Invoice.where(invoice_date: start_date..end_date).order(invoice_date: :asc)
    end

    #top_dates = Invoice.select("DATE(invoice_date) AS date, COUNT(*) AS count").group("DATE(invoice_date)").order("count DESC").limit(10)



    if invoices.present?
      render json: {
        success: true,
        message: 'Invoices retrieved successfully',
        invoices: invoices
      }, status: :ok
    else
      render json: {
        success: true,
        message: 'No invoices found',
        invoices: []
      }, status: :ok
    end
  end
end

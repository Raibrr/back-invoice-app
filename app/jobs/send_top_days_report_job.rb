class SendTopDaysReportJob < ApplicationJob
  queue_as :default

  def perform
    top_days = Invoice
                .select("DATE(invoice_date) AS date, COUNT(*) AS count")
                .group("DATE(invoice_date)")
                .order("count DESC")
                .limit(10)

    TopDaysMailer.report(top_days).deliver_now
  end
end

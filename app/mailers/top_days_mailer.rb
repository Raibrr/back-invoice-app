class TopDaysMailer < ApplicationMailer
    def report(top_days)
        @top_days = top_days
        mail(
            to: "admin@example.com",
            subject: "Top 10 días con más ventas"
        )
    end
end

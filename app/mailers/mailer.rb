# frozen_string_literal: true

class Mailer < ApplicationMailer
  def mailer_notification(notification)
    @notification = notification
    mail(to: [@notification.from.email])
  end
end

# frozen_string_literal: true

module WelcomeEmail
  extend ActiveSupport::Concern

  included do
    after_create :send_welcome_email
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end

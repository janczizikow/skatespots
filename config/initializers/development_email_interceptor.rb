# 1. Uncomment to send emails in development
# 2. Change config:
#    /config/environments/development.rb:
#    config.action_mailer.delivery_method = :smtp

if Rails.env.development?
  require "email_interceptor"
  ActionMailer::Base.register_interceptor(EmailInterceptor)
end

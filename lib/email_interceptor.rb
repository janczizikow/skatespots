# frozen_string_literal: true

class EmailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = ['jan.czizikow@gmail.com']
  end
end

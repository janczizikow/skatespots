# frozen_string_literal: true

module DefaultUrl
  def default_url_options
    {host: ENV['HOST'] || 'localhost:3000'}
  end
end

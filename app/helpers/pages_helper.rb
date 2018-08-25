# frozen_string_literal: true

module PagesHelper
  def home?
    controller_name == 'pages' && action_name == 'home'
  end
end

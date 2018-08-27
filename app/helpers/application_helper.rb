# frozen_string_literal: true

module ApplicationHelper
  def spots_listing?
    controller_name == 'spots' && action_name == 'index'
  end
end

# frozen_string_literal: true

class ReviewDecorator < Draper::Decorator
  def posted_date
    object.created_at.strftime('%b %d, %Y')
  end
end

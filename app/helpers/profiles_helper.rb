# frozen_string_literal: true

module ProfilesHelper
  # FIXME: read more about delagation
  def user_spots
    current_user.spots
  end
end

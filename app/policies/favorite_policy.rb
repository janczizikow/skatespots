# frozen_string_literal: true

class FavoritePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def index?
    user.present?
  end

  def create?
    index?
  end

  def destroy?
    record.user == user
  end
end

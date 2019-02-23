# frozen_string_literal: true

class SpotPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.active
    end
  end

  def show?
    true
  end

  def new?
    !user.nil?
  end

  def create?
    new?
  end

  def edit?
    record.user == user
  end

  def update?
    edit?
  end

  def destroy?
    update?
  end
end

# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @spots = Spot.active.limit(12).order('created_at DESC')
  end

  def account; end

  def spots; end
end

# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_user

  def update
    # FIXME: HANDLE CITY UPDATE
    update_city if @user.city != profile_params[:city] && profile_params[:city].present?
    if @user.update(
      avatar: profile_params[:avatar],
      username: profile_params[:username],
      name: profile_params[:name]
    )
      flash[:notice] = 'Profile updated!'
      redirect_to account_path
    else
      flash[:alert] = @user.errors.full_messages
      render 'pages/account'
    end
  end

  private

  def set_user
    @user = current_user
    authorize @user
  end

  def update_city
    city_result = CreateCity.new(city: profile_params[:city]).call
    if city_result.success?
      @user.city = city_result.data
    else
      render 'pages/account', error: city_result.error
    end
  end

  def profile_params
    params.require(:user).permit(:avatar, :username, :name, :city, :description)
  end
end

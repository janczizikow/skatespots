# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_user

  def update
    # FIXME: HANDLE CITY UPDATE
    if @user.update(
      avatar: profile_params[:avatar],
      username: profile_params[:username],
      name: profile_params[:name]
    )
      flash[:notice] = 'Profile updated!'
      redirect_to account_path
    else
      flash[:alert] = @user.errors.full_messages
      render 'pages#account'
    end
  end

  private

  def set_user
    @user = current_user
    authorize @user
  end

  def profile_params
    params.require(:user).permit(:avatar, :username, :name, :city, :description)
  end
end

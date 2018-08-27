# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_user

  def update
    if @user.update(avatar: profile_params[:avatar], username: profile_params[:username], name: profile_params[:name])
      respond_to do |format|
        format.html { redirect_to account_path }
      end
    else
      respond_to do |format|
        format.html { render 'pages#account' }
      end
    end
  end

  def destroy
    # TODO: SET INACTIVE FLAG
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

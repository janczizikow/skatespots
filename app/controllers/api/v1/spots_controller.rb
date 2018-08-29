# frozen_string_literal: true

class Api::V1::SpotsController < ActionController::API
  include Pundit

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  rescue_from StandardError,                with: :internal_server_error
  rescue_from Pundit::NotAuthorizedError,   with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @spots = if params[:lat].present? && params[:lng].present?
             elsif params[:geocode].present?
               # Spot.near(params[:geocode], 50)
             else
              policy_scope(Spot.active)
             end
  end

  private

  def user_not_authorized(exception)
    render json: {
      error: "Unauthorized #{exception.policy.class.to_s.underscore.camelize}.#{exception.query}"
    }, status: :unauthorized
  end

  def not_found(exception)
    render json: {error: exception.message}, status: :not_found
  end

  def internal_server_error(exception)
    if Rails.env.development?
      return response = {
        type: exception.class.to_s,
        message: exception.message, backtrace: exception.backtrace
      }
    else
      return response = {error: 'Internal Server Error'}
    end

    render json: response, status: :internal_server_error
  end
end

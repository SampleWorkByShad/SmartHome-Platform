class MeController < ApplicationController
  include Authable

  before_action :require_auth

  def index
    render json: {
      id: @current_user.id,
      name: @current_user.name,
      username: @current_user.username,
      photo: @current_user.photo,
      roles: @current_user.roles
    }
  end

  def apps
    render json: @current_user.apps.all.to_json(:include => :app_redirects)
  end
end

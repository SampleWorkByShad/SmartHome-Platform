class UsersController < ApplicationController
  include Authable
  include Usersable

  skip_before_action :verify_authenticity_token

  before_action :require_auth
  before_action -> { require_role_any_of ['admin'] }

  before_action :load_user, only: [:show, :update, :destroy]

  def index
    render json: User.all
  end

  def show
    render json: @user
  end

  def create
    @user = User.new user_params

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end
end

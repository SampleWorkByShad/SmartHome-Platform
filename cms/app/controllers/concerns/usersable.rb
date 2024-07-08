module Usersable
  extend ActiveSupport::Concern

  private
    def load_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
    end
end
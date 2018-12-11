class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
    user.email = user_params[:email].lstrip.rstrip.downcase

    if user.save
      session[:user_id] = user.id
      redirect_to [:products], notice: 'User created!'
    else
      redirect_to '/signup'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
      )
  end

end

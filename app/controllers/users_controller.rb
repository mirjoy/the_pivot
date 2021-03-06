class UsersController < ApplicationController
  # before_filter :authorize, :only => [:show]

  def new
    @user = User.new
  end

  def show
    unless signed_in?
      flash[:danger] = "You must sign in to see your account."
      redirect_to root_path
    end
    @orders = Order.where(user_id: current_user.id)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_creation_confirmation(@user).deliver_now
      flash[:info] = "Welcome to the Gallery!"
      sign_in
    else
      flash[:error] = "Invalid input, please try again"
      redirect_to :back
    end
  end

  def edit

  end

  def update
    if current_user.update(user_params)
      redirect_to account_path
      flash[:notice] = "Successfully Updated"
    else
      flash[:notice] = "Profile Not Updated"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :display_name, :email, :password, :password_confirmation)
  end

  def sign_in
    session[:user_id] = @user.id
    redirect_to :back
  end

end

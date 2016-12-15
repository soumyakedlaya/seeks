class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:Email])
    # puts "\n\n\n user:"
    # puts user
    if user && user.authenticate(params[:Password])
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}"
    else
      initialize_flash
      flash[:errors] << "Invalid email and password combination"
      redirect_to "/sessions/new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/sessions/new"
  end
end

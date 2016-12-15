class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
  end

  def show
    @user = User.find(params[:id])
    @secrets = @user.secrets
    # @secrets = Secret.where(user_id: session[:user_id])
    @secrets_user_liked = @user.secrets_liked
  end

  def create
    if params[:user][:password] == params[:user][:password_confirmation]
      # puts "Params[:password]: #{params[:user][:password]}"
      # puts "Params[:password_confirmation]: #{params[:user][:password_confirmation]}"
      @user = User.new(user_params)
      puts "******** #{@user}"
      puts @user.password
      if !@user.valid?
        initialize_flash
        flash[:errors] << @user.errors.full_messages
        redirect_to '/users/new'
      else
        @user.save
        session[:user_id] = @user.id
        redirect_to "/users/#{@user.id}"
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  @user = User.find(params[:id])
    if @user.update(name: params[:user][:name], email:params[:user][:email])
    #WRITE IT THIS WAY BC:
    #   params = {
    #   user => {
    #     name => "shane"
    #   }
    #   id => 5
    # }

      redirect_to "/users/#{@user.id}"
    else
      initialize_flash
      flash[:errors] << @user.errors.full_messages
      redirect_to "/users/#{@user.id}"
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    session[:user_id]=nil
    redirect_to '/sessions/new'
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end

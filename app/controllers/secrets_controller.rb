class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]
  def index
    @secrets = Secret.all

  end

  def create
    @user = current_user
    @secret = @user.secrets.create(secrets_params)
    if !@secret.valid?
      initialize_flash
      flash[:errors] << @secret.errors.full_messages
      redirect_to "/users/#{@user.id}"
    else
      @secret.save
      redirect_to "/users/#{@user.id}"
    end
  end

  def destroy
    secret = Secret.find(params[:id])
    # binding.pry
    secret.destroy if secret.user == current_user
    redirect_to "/users/#{current_user.id}"
  end

  private
    def secrets_params
      params.require(:secret).permit(:content, :user_id)
    end
end

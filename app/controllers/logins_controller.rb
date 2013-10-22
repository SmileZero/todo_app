class LoginsController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new logins_params
  	if @user.registered?
  		session[:login] = @user.id
  		redirect_to todos_path
  	else
  		render "new", notice: 'Invalid email/password combination'
  	end
  end

  def destroy
  	session[:login] = nil
  	redirect_to root_url
  end

  private
    def logins_params
      params.require(:user).permit(:password_digest, :email)
    end
end

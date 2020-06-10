class PasswordsController < ApplicationController
 
 def new
 end
 
 def create
  chef = Chef.find_by_email(params[:email])
  chef.send_password_reset if chef
  flash[:success] = 'E-mail sent with password reset instructions.'
  redirect_to login_path
 end	

 def edit
  @chef = Chef.find_by_reset_password_token!(params[:id])
 end

def update
  @chef = Chef.find_by_reset_password_token!(params[:id])
  if @chef.password_reset_sent_at < 2.hour.ago
    flash[:success] = 'Password reset has expired'
    redirect_to new_password_path
  elsif @chef.update(user_params)
    flash[:success] = 'Password has been reset!'
    redirect_to login_path
  else
    render 'edit'
  end
end

private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:chef).permit(:password)
  end

end

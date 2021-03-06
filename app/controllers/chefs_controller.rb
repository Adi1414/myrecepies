class ChefsController < ApplicationController

before_action :set_chef, only: [:show,:edit,:destroy,:update]
before_action :require_same_user, only: [:destroy, :edit,:update]
before_action :require_admin, only: [:destroy]

def index
 @chefs= Chef.all
end

def new
  @chef = Chef.new
end

  
def create
  @chef = Chef.new(perimited_chef_params)
  if @chef.save
    # session[:chef_id] = @chef.id
    # cookies.signed[:chef_id] = @chef.id
    # @chef.confirm_code = get_random(6)
    ChefMailer.sample_email(@chef).deliver_now
    flash[:success] = "Please confirm your email address to continue"
  	# redirect_to chef_path(@chef)
    redirect_to root_url
  else 
  	render 'new'
  end
end

def destroy
  # @chef = Chef.find(params[:id])
  if !@chef.admin
  @chef.destroy
  flash[:danger] = "Chef and its associated recipes has been deleted"
  redirect_to chefs_path
   end
end 

def show
   # @chef = Chef.find(params[:id])
end	

def edit
  # @chef = Chef.find(params[:id])
end

def update
   # @chef = Chef.find(params[:id])
  if @chef.update(perimited_chef_params)
    flash[:success] = "#{@chef.chefname} updated successfully"
    #redirect_to @chef

  else
    render 'edit'
  end
end  

def confirm_email
    chef = Chef.find_by_confirm_code(params[:id])
    if chef
      chef.email_activate
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
      redirect_to login_url
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
end

private 

def perimited_chef_params
   params.require(:chef).permit(:chefname, :email, :password, :password_confirmation, :confirmed, :confirm_code)
end

def set_chef
  @chef = Chef.find(params[:id])
 end

def require_same_user
 if current_chef != @chef && !current_chef.admin?
    flash[:danger] = "You can only edit delete your own account "
   redirect_to chefs_path
 end
end  

def require_admin
  if logged_in? & !current_chef.admin?
  flash[:danger] = "Only admin users can perform that action"
  redirect_to root_path
end
end

# def get_random(num)
#   charset = Array('A'..'Z') + Array('a'..'z') + Array(1..9)
#   Array.new(num) { charset.sample }.join
# end  

end	
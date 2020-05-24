class ChefsController < ApplicationController

before_action :set_chef, only: [:show,:edit,:destroy,:update]

def index
 @chefs= Chef.all
end

def new
  @chef = Chef.new
end

def create
  @chef = Chef.new(perimited_chef_params)
  if @chef.save
    session[:chef_id] = @chef.id
    flash[:success] = "Welcome #{@chef.chefname} to this app"
  	redirect_to chef_path(@chef)
  else 
  	render 'new'
  end
end

def destroy
  # @chef = Chef.find(params[:id])
  @chef.destroy
  flash[:danger] = "Chef and its associated recipes has been deleted"
  redirect_to chefs_path
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
    redirect_to @chef
  else
    render 'edit'
  end
end  

private 

def perimited_chef_params
   params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
end

def set_chef
  @chef = Chef.find(params[:id])
 end

end	
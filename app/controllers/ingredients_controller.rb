class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:edit,:update, :show]
  before_action :require_admin, except: [:index, :show]
  
  def new
   @ingredient = Ingredient.new 
  end
  
  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save 
      flash[:success]="Ingredient added successfully"
      redirect_to @ingredient
    else
      render 'new'  
    end
  end
  
  def edit
    
  end
  
  def update
    if @ingredient.update(ingredient_params) 
      flash[:success]="Ingredient updated successfully"
      redirect_to @ingredient
    else
      render 'edit'  
    end
  end
  
  def show
    
  end
  
  def index
    @ingredients = Ingredient.all
  end
  
  private 
  def set_ingredient
   @ingredient = Ingredient.find(params[:id])
  end

  def require_admin
    if !logged_in? || ( logged_in? && !current_chef.admin?)
     flash[:danger] = "Only admin users can perform that action"
     redirect_to ingredients_path
   end
 end

   def ingredient_params
    params.require(:ingredient).permit(:name)
   end 
end
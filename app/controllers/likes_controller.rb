class LikesController < ApplicationController
 before_action :require_user
 before_action :find_recipe
 before_action :find_like, only: [:destroy]

 def create
   if already_liked?
    flash[:notice] = "You can't like more than once"
  else
    @recipe.likes.create(chef_id: current_chef.id)
  end
   redirect_to recipe_path(@recipe)
 end	

 def destroy
  if !(already_liked?)
    flash[:notice] = "Cannot unlike"
  else
    @like.destroy
  end
  redirect_to recipe_path(@recipe)
end


private
 def find_recipe
   @recipe = Recipe.find(params[:recipe_id])
 end	

def already_liked?
  Like.where(chef_id: current_chef.id, recipe_id:
  params[:recipe_id]).exists?
end

def find_like
   @like = @recipe.likes.find(params[:id])
end

end

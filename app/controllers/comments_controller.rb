class CommentsController < ApplicationController
before_action :require_user


def create
 @recipe = Recipe.find(params[:recipe_id])
 @comment = @recipe.comments.build(comment_params)
 @comment.chef = current_chef
if @comment.save
	# ActionCable.server.broadcast "comments", render(partial: 'comments/comment', object: @comment)
    ActionCable.server.broadcast "comments",render(partial: 'comments/comment', object: @comment)
   # flash[:success] = "Successfully saved comment."
   # redirect_to recipe_path(@recipe)
else
   flash[:danger]="Comment not saved."
   redirect_to :back   	
end	
end

def comment_params
	params.require(:comment).permit(:description)
end

end
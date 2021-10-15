class CommentsController < ApplicationController

  def create
   
    if  @comment=Comment.create(comment_params)
      redirect_to prototype_path(@comment.prototype_id)
    else 
      render "prototypes/show"
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content).merge(prototype_id:params[:prototype_id],user_id:current_user.id)
    end
end

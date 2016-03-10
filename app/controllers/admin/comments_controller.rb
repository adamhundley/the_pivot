class Admin::CommentsController < Admin::BaseController
  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      flash[:info] = "Comments on comments."
      redirect_to admin_order_path(params[:comment][:order_id])
    else
      flash[:alert] = "Sorry, friend.  Something went wrong :(... Please try again."
      redirect_to admin_order_path(params[:comment][:order_id])
    end
  end

private
  def comment_params
    params.require(:comment).permit(:order_id, :comment)
  end
end

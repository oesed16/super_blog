class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    
    if @comment.save
      flash[:notice] = "El comentario fue publicado con éxito."
      redirect_to post_path(@post.id)
    else
      flash[:alert] = "La publicación del comentario falló, intenta nuevamente."
      redirect_to post_path(@post.id)
    end
  end

  private
    
  def comment_params
      params.require(:comment).permit(:user_id, :post_id, :comentario)
  end
end

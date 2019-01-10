class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "El Post fue eliminado exitosamente"
    redirect_to root_path
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "El post fue creado exitosamente"
      redirect_to root_path
    else
      flash[:alert] = "El registro del post falló, intenta nuevamente"
      render :new 
    end

  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "El post fue modificado exitosamente"
      redirect_to root_path
    else
      flash[:alert] = "La actualización del post falló, intenta nuevamente"
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :titulo, :cuerpo)
  end
end

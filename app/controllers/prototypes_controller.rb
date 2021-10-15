class PrototypesController < ApplicationController
  before_action :prototype_find,only:[:show,:edit]
  before_action :authenticate_user!,only:[:new,:edit,:destroy]
  before_action :move_index,only:[:edit]
  def index
    @prototypes=Prototype.includes(:user)
  end

  def new
    @prototype=Prototype.new
  end

  def create
    @prototype=Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else 
      render :new
    end
  end

  def show
    @comment=Comment.new
    @comments=@prototype.comments.includes(:user)
  end

  def edit
   
  end

  def update
    prototype=Prototype.find(params[:id])
    if prototype.update(prototype_params)
      redirect_to prototype_path(prototype)
    else 
      @prototype=Prototype.find(params[:id])
      render :edit
    end
  end

  def destroy
    prototype=Prototype.destroy(params[:id])
    redirect_to root_path
  end


  private
    def prototype_params
     
      params.require(:prototype).permit(:title,:catch_copy,:concept,:image).merge(user_id:current_user.id)
    end

    def prototype_find
      @prototype=Prototype.find(params[:id])
    end

    def move_index
      prototype=Prototype.find(params[:id])
      unless prototype.user_id == current_user.id
        redirect_to root_path
      end
    end
end

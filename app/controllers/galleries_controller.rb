class GalleriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @user = User.find(params[:user_id])
    @galleries = @user.galleries.with_attached_photos
    puts @galleries
  end

  def show
    @gallery = Gallery.find(params[:id])
    @images = @gallery.images
  end

  def new
    @user = User.find(params[:user_id])
    @gallery = Gallery.new
  end

  def create
    @user = User.find(params[:user_id])
    @gallery = @user.galleries.new(gallery_params)

    if @gallery.save
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @gallery = Gallery.find(params[:id])

    if @gallery.destroy
      redirect_to galleries_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  def gallery_params
    params.require(:gallery).permit(:title, :user_id, photos:[])
  end
end

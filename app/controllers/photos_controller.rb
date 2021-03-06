class PhotosController < ApplicationController
  def index
    @photos = Photo.all
  end
  def show
    @photo = Photo.find(params[:id])
    @commentable = @photo
    @comments = @commentable.comments
    @comment = Comment.new
  end
  def new
    @photo = Photo.new
  end
  def edit
    @photo = Photo.find(params[:id])
  end
  def create
    @photo = Photo.new(allowed_params)
    if @photo.save
      redirect_to @photo, notice: "Photo was successfully created."
    else
      render :new
    end
  end
  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(allowed_params)
      redirect_to @photo, notice: "Photo was successfully updated."
    else
      render :edit
    end
  end
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to photos_url, notice: "Photo was destroyed."
  end
  private 
  def allowed_params
    params.require(:photo).permit!
  end
end

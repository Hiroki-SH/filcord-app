class PhotosController < ApplicationController
  before_action :logged_in_user

  def create
    @film = Film.find(params[:film_id])
    @photo = @film.photos.build(photo_params)
    if @photo.save
      redirect_to @film
    else
      @photos = @film.photos.paginate(page: params[:page])
      render 'films/show'
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    film = Film.find(params[:film_id])
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      # flash[:success] = "撮影情報を更新しました！"
      redirect_to film
    else
      render :edit
    end
  end

  def destroy
  end

  private
    def photo_params
      params.require(:photo).permit(:f_number, :shutter_speed)
    end
end

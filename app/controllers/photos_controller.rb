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
  end

  def update
  end

  def destroy
  end

  private
    def photo_params
      params.require(:photo).permit(:f_number, :shutter_speed)
    end
end

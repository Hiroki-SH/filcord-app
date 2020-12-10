class PhotosController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def show
  end


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
    if @photo.update(photo_params)
      # flash[:success] = "撮影情報を更新しました！"
      redirect_to film_url(@photo.film_id)
    else
      render :edit
    end
  end

  def destroy
    @photo.destroy
    redirect_to film_url(@photo.film_id)
  end

  private
    def photo_params
      params.require(:photo).permit(:f_number, :shutter_speed, :lat, :lng)
    end

    def correct_user
      @photo = Photo.find(params[:id])
      unless @photo.user == current_user
        store_location #現在のURLを保存。ログイン後このURLにリダイレクト
        redirect_to (login_url)
      end
    end
end

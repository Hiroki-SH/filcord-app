class PhotosController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @film_id = params[:film_id]
    @photo = Photo.new
  end


  def create
    @film_id = params[:film_id]
    @film = Film.find(params[:film_id])
    @photo = @film.photos.build(photo_params)
    if @photo.save
      flash[:success] = "撮影記録を追加しました"
      redirect_to @film
    else
      @photos = @film.photos.paginate(page: params[:page])
      flash.now[:danger] = "撮影記録の追加に失敗しました"
      render :new
    end
  end

  def edit
  end

  def update
    if @photo.update(photo_params)
      flash[:success] = "撮影記録を更新しました"
      redirect_to film_url(@photo.film_id)
    else
      flash.now[:danger] = "撮影記録の更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @photo.destroy
    flash[:success] = "撮影記録を削除しました"
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

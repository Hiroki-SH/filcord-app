class PhotosController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action -> { correct_user_film(params[:film_id]) }, only: [:create]

  def show
  end

  def new
    @film_id = params[:film_id]
    @photo = Photo.new(session[:photo] || {})
  end


  def create
    @film_id = params[:film_id]
    @photo = @film.photos.build(photo_params)
    if @photo.save
      flash[:success] = "撮影記録を追加しました"
      session[:photo] = nil
      redirect_to @film
    else
      # @photos = @film.photos.paginate(page: params[:page])
      flash[:danger] = "撮影記録の追加に失敗しました"
      flash[:validation_error] = @photo.errors.full_messages
      session[:photo] = @photo.attributes.slice(*photo_params.keys) #sessionにフォームで入力された値のみ保存
      redirect_to new_photo_url(film_id: @film.id)
    end
  end

  def edit
  end

  def update
    if @photo.update(photo_params)
      flash[:success] = "撮影記録を更新しました"
      redirect_to film_url(@photo.film_id)
    else
      flash[:danger] = "撮影記録の更新に失敗しました"
      flash[:validation_error] = @photo.errors.full_messages
      redirect_to edit_photo_url(@photo)
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

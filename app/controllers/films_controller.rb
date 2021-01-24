class FilmsController < ApplicationController
  before_action :logged_in_user
  before_action -> { correct_user_film(params[:id]) }, only: [:show, :edit, :update, :destroy]

  def show
    @photos = @film.photos.paginate(page: params[:page])
    @photo = Photo.new
  end

  def new
    @film = Film.new(session[:film] || {})
  end

  def create
    @film = current_user.films.build(film_params)
    if @film.save
      flash[:success] = "新しいフィルムを登録しました"
      session[:film] = nil
      redirect_to user_url
    else
      flash[:danger] = "フィルムの登録に失敗しました"
      flash[:validation_error] = @film.errors.full_messages
      session[:film] = @film.attributes.slice(*film_params.keys) #sessionにフォームで入力された値のみ保存
      redirect_to new_film_url
    end
  end

  def edit
  end

  def update
    if @film.update(film_params)
      flash[:success] = "フィルム情報を更新しました"
      redirect_to user_url
    else
      flash[:danger] = "フィルムの更新に失敗しました"
      flash[:validation_error] = @film.errors.full_messages
      redirect_to edit_film_url(@film)
    end
  end

  def destroy
    @film.destroy
    flash[:success] = "フィルムを削除しました"
    redirect_to user_url
  end

  private
    def film_params
      params.require(:film).permit(:name, :company, :iso)
    end
end

class FilmsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  def index
    @films = Film.all
  end

  def show
    @photos = @film.photos.paginate(page: params[:page])
    @photo = Photo.new
  end

  def new
    @film = Film.new
  end

  def create
    @film = current_user.films.build(film_params)
    if @film.save
      # flash[:success] = "新しいフィルムを登録しました！"
      # redirect_to @film
      redirect_to user_url
    else
      render 'films/new'
    end
  end

  def edit
  end

  def update
    if @film.update(film_params)
      # flash[:success] = "フィルム情報を更新しました！"
      # redirect_to @film
      redirect_to user_url
    else
      render 'films/edit'
    end
  end

  def destroy
    @film.destroy
    # flash[:success] = "フィルムを削除しました！"
    redirect_to user_url
  end

  private
    def film_params
      params.require(:film).permit(:name, :company, :iso)
    end

    def correct_user
      @film = Film.find(params[:id])
      unless @film.user == current_user
        store_location #現在のURLを保存。ログイン後このURLにリダイレクト
        redirect_to (login_url) 
      end
    end
end

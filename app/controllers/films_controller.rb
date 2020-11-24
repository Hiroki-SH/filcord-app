class FilmsController < ApplicationController
  before_action :logged_in_user
  def index
    @films = Film.all
  end

  def show
    @film = Film.find(params[:id])
  end

  def new
    @film = Film.new
  end

  def create
    @film = Film.new(film_params)
    if @film.save
      # flash[:success] = "新しいフィルムを登録しました！"
      redirect_to films_url
    else
      render 'films/new'
    end
  end

  def edit
    @film = Film.find(params[:id])
  end

  def update
    @film = Film.find(params[:id])
    if @film.update(film_params)
      # flash[:success] = "フィルム情報を更新しました！"
      redirect_to @film
    else
      render 'films/edit'
    end
  end

  def destroy
    Film.find(params[:id]).destroy
    # flash[:success] = "フィルムを削除しました！"
    redirect_to films_url
  end

  private
    def film_params
      params.require(:film).permit(:name, :company, :iso)
    end

end

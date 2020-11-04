class FilmsController < ApplicationController
  def index
    @films = Film.all
  end

  def show
  end

  def new
    @film = Film.new
  end

  def create
    @film = Film.new(film_params)
    if @film.save
      flash[:success] = "新しいフィルムを登録しました！"
      redirect_to films_url
    else
      render 'films/new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def film_params
      params.require(:film).permit(:name, :company, :iso)
    end

end

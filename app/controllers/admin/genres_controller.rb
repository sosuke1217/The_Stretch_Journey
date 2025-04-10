class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'
  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      redirect_to admin_genres_path
    else
      render :new
    end
  end

  def index
    @genres = Genre.all
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])

    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to admin_genres_path
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end


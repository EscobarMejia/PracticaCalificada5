class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find_by(id: id) # look up movie by unique ID
    if @movie.nil?
      flash[:notice] = "La película no existe."
      redirect_to not_found_path
    else
      render(:partial => 'movie', :object => @movie) if request.xhr?
    end
    # will render app/views/movies/show.<extension> by default
  end

  def not_found
    render 'not_found'
    end
  def new
    @movie = Movie.new
  end 
  def create
    if (@movie = Movie.create(movie_params))
      redirect_to movies_path, :notice => "#{@movie.title} created."
    else
      flash[:alert] = "Movie #{@movie.title} could not be created: " +
        @movie.errors.full_messages.join(",")
      render 'new'
    end
  end
  def edit
    @movie = Movie.find params[:id]
  end
  def update
    @movie = Movie.find params[:id]
    if (@movie.update(movie_params))
      redirect_to movie_path(@movie), :notice => "#{@movie.title} updated."
    else
      flash[:alert] = "#{@movie.title} could not be updated: " +
        @movie.errors.full_messages.join(",")
      render 'edit'
    end
  end
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, :notice => "#{@movie.title} deleted."
  end
  private
  def movie_params
    params.require(:movie)
    params[:movie].permit(:title,:rating,:release_date)
  end

end


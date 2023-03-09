class CitiesController < ApplicationController
  before_action :set_city, only: %i[ show update destroy ]

  def index
    @cities = City.all

    render json: @cities
  end

  def show
    @city = City.find_by_id(params[:id])

    if @city.nil?
      render json: { message: 'Cidade não encontrada' }, status: :not_found
    else
      render json: @city, status: :ok
    end
  end

  def create
    @city = City.new(city_params)

    if @city.save
      render json: @city, status: :created, location: @city
    else
      render json: @city.errors, status: :unprocessable_entity
    end
  end

  def update
    if @city.nil?
      render json: { message: 'Cidade não encontrada' }, status: :not_found
    else
      if @city.update(city_params)
        render json: @city
      else
        render json: @city.errors, status: :unprocessable_entity
      end
    end

  end

  def destroy
    if @city.nil?
      render json: { message: 'Cidade não encontrada' }, status: :not_found
    else
      if @city.destroy
        render status: :no_content
      else
        render json: @city.errors, status: :unprocessable_entity
      end
    end

  end

  private
    def set_city
      @city = City.find_by_id(params[:id])
    end

    def city_params
      params.require(:city).permit(:name, :uf_id)
    end
end

class TravelsController < ApplicationController
  before_action :set_travel, only: %i[ show update destroy ]

  def index
    @travels = Travel.all

    @date_of_origin = params[:start_date].blank? ? "2020-01-01" : params[:start_date]
    @destination_date = params[:end_date].blank? ? "2030-12-29" : params[:end_date]

    @travels = Travel.where("travels.date_of_origin BETWEEN ? AND ? AND travels.destination_date BETWEEN ? AND ?",
      @date_of_origin, @destination_date, @date_of_origin, @destination_date)
      .merge(Travel.joins(:truck_driver)
        .where("truck_drivers.name LIKE ?", "%#{params[:truck_driver]}%"))
      .merge(Travel.joins(:destination_city)
        .where("cities.name LIKE ?", "#{params[:destination_city]}%"))
      .merge(Travel.joins(:origin_city)
        .where("origin_cities_travels.name LIKE ?", "#{params[:origin_city]}%"))
      .merge(Travel.joins(:product_type)
        .where("product_types.description LIKE ?", "#{params[:product_type]}%"))

    render json: @travels
  end

  def show
    @travel = Travel.find_by_id(params[:id])
    if @travel.nil?
      render json: { message: 'Viagem não encontrada' }, status: :not_found
    else
      render json: @travel
    end
  end

  def create
    @travel = Travel.new(travel_params)

    if @travel.save
      render json: @travel, status: :created, location: @travel
    else
      render json: @travel.errors, status: :unprocessable_entity
    end
  end

  def update
    if @travel.nil?
      render json: { message: 'Viagem não encontrada' }, status: :not_found
    else
      if @travel.update(travel_params)
        render json: @travel, status: :ok
      else
        render json: @travel.errors, status: :unprocessable_entity
      end
    end

  end

  def destroy
    if @travel.nil?
      render json: { message: 'Viagem não encontrada' }, status: :not_found
    else
      if @travel.destroy
        render status: :no_content
      else
        render json: @travel.errors, status: :unprocessable_entity
      end
    end
  end

  private
    def set_travel
      @travel = Travel.find_by_id(params[:id])
    end

    def travel_params
      params.require(:travel).permit(:destination_date, :date_of_origin, :expected_date,
        :origin_city_id, :destination_city_id, :truck_driver_id, :product_type_id)
    end
end

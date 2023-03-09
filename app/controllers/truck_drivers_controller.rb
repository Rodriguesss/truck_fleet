class TruckDriversController < ApplicationController
  before_action :set_truck_driver, only: %i[ show update destroy ]

  def index
    @truck_drivers = TruckDriver.all

    render json: @truck_drivers
  end

  def show
    if @truck_driver.nil?
      render json: { message: "Motorista de caminhão não encontrado" }, status: :not_found
    else
      render json: @truck_driver
    end
  end

  def create
    @truck_driver = TruckDriver.new(truck_driver_params)

    if @truck_driver.save
      render json: @truck_driver, status: :created, location: @truck_driver
    else
      render json: @truck_driver.errors, status: :unprocessable_entity
    end
  end

  def update
    if @truck_driver.nil?
      render json: { message: "Motorista de caminhão não encontrado" }, status: :not_found
    else
      if @truck_driver.update(truck_driver_params)
        render json: @truck_driver
      else
        render json: @truck_driver.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @truck_driver.nil?
      render json: { message: "Motorista de caminhão não encontrado" }, status: :not_found
    else
      if @truck_driver.destroy
        render status: :no_content
      else
        render json: @truck_driver.errors, status: :unprocessable_entity
      end
    end
  end

  private
    def set_truck_driver
      @truck_driver = TruckDriver.find_by_id(params[:id])
    end

    def truck_driver_params
      params.require(:truck_driver).permit(:name, :age)
    end
end

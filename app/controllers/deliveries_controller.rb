class DeliveriesController < ApplicationController
  before_action :set_delivery, only: %i[ show update destroy ]

  def index
    @deliveries = Delivery.joins(travel: :truck_driver)
      .group_by { |delivery| [delivery.travel.truck_driver.name, delivery.travel.destination_date.month] }

    @result = @deliveries.map do |(driver_name, month), deliveries|
      travel_id = deliveries.first.travel_id
      product_type_id = Travel.find(travel_id).product_type_id
      product_type_description = ProductType.find(product_type_id).description
      deliveries_count = deliveries.count

      product_id = deliveries.first.product_id
      product = Product.find(product_id)

      {
        name: driver_name,
        deliveries: {
          Date::MONTHNAMES[month].downcase => [{
            payload_type: product_type_description,
            count: deliveries_count,
            total_billing: "R$ #{deliveries_count * product.price}"
          }]
        }
      }
    end

    render json: @result
  end

  def show
    @delivery = Delivery.find_by_id(params[:id])

    if @delivery.nil?
      render json: { message: "Entrega não encontrada" }, status: :not_found
    else
      render json: @delivery, status: :ok
    end
  end

  def create
    @delivery = Delivery.new(delivery_params)

    if @delivery.save
      render json: @delivery, status: :created, location: @delivery
    else
      render json: @delivery.errors, status: :unprocessable_entity
    end
  end

  def update
    if @delivery.nil?
      render json: { message: "Entrega não encontrada" }, status: :not_found
    else
      if @delivery.update(delivery_params)
        render json: @delivery
      else
        render json: @delivery.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @delivery.nil?
      render json: { message: "Entrega não encontrada" }, status: :not_found
    else
      if @delivery.destroy
        render status: :no_content
      else
        render json: @delivery.errors, status: :unprocessable_entity
      end
    end
  end

  private
    def set_delivery
      @delivery = Delivery.find_by_id(params[:id])
    end

    def delivery_params
      params.require(:delivery).permit(:travel_id, :product_id)
    end
end

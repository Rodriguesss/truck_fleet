class ProductTypesController < ApplicationController
  before_action :set_product_type, only: %i[ show update destroy ]

  def index
    @product_types = ProductType.all

    render json: @product_types
  end

  def show
    @product_types = ProductType.find_by_id(params[:id])
    if @product_type.nil?
      render json: { message: "Tipo de produto não encontrado" }, status: :not_found
    else
      render json: @product_type, status: :ok
    end
  end

  def create
    @product_type = ProductType.new(product_type_params)

    if @product_type.save
      render json: @product_type, status: :created, location: @product_type
    else
      render json: @product_type.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product_type.nil?
      render json: { message: "Tipo de produto não encontrado" }, status: :not_found
    else
      if @product_type.update(product_type_params)
        render json: @product_type
      else
        render json: @product_type.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @product_type.nil?
      render json: { message: "Tipo de produto não encontrado" }, status: :not_found
    else
      if @product_type.destroy
        render status: :no_content
      else
        render json: @product_type.errors, status: :unprocessable_entity
      end
    end
  end

  private
    def set_product_type
      @product_type = ProductType.find_by_id(params[:id])
    end

    def product_type_params
      params.require(:product_type).permit(:description)
    end
end

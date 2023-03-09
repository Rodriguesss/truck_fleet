class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show update destroy ]

  def index
    @products = Product.all

    render json: @products
  end

  def show
    @product = Product.find_by_id(params[:id])
    if @product.nil?
      render json: { message: "Produto não encontrado" }, status: :not_found
    else
      render json: @product, status: :ok
    end
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product.nil?
      render json: { message: "Produto não encontrado" }, status: :not_found
    else
      if @product.update(product_params)
        render json: @product
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @product.nil?
      render json: { message: "Produto não encontrado" }, status: :not_found
    else
      if @product.destroy
        render status: :no_content
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end
  end

  private
    def set_product
      @product = Product.find_by_id(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :weight, :dimension, :description)
    end
end

class UfsController < ApplicationController
  before_action :set_uf, only: %i[ show update destroy ]

  def index
    @ufs = Uf.all

    render json: @ufs
  end

  def show
    @uf = Uf.find_by_id(params[:id])
    if @uf.nil?
      render json: { message: 'Uf não encontrada' }, status: :not_found
    else
      render json: @uf, status: :ok
    end
  end

  def create
    @uf = Uf.new(uf_params)

    if @uf.save
      render json: @uf, status: :created, location: @uf
    else
      render json: @uf.errors, status: :unprocessable_entity
    end
  end

  def update
    if @uf.nil?
      render json: { message: "Uf não encontrada" }, status: :not_found
    else
      if @uf.update(uf_params)
        render json: @uf
      else
        render json: @uf.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy

    if @uf.nil?
      render json: { message: "Uf não encontrada" }, status: :not_found
    else
      if @uf.destroy
        render status: :no_content
      else
        render json: @uf.errors, status: :unprocessable_entity
      end
    end
  end

  private
    def set_uf
      @uf = Uf.find_by_id(params[:id])
    end

    def uf_params
      params.require(:uf).permit(:name)
    end
end

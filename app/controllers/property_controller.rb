class PropertyController < ApplicationController
  before_action :authenticate_user!
  before_action :find_params, only: [:show, :edit, :update, :destroy]

  def index
    @property = Property.all
  end

  def show
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @property.update(property_params)
      redirect_to property_path(@property.id)
    else
      render :edit
    end
  end

  def destroy
    if @property.destroy
      redirect_to property_index_path
    else
      render :show
    end
  end

  private

  def find_params
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:postal_code, :prefecture, :city, :address_line, :building, :total_units, :building_year, :property_type, :business_entity)
  end
end

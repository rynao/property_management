class PropertyController < ApplicationController
  before_action :find_params, only: [:show, :edit, :update, :destroy]

  def summary
    @payments = Payment.joins(:property, :contract, :user)
                .where(user_id: current_user.id).order(:paid_date)
                .group('paid_date').sum('contracts.rent')
                
    gon.all_labels = @payments.map{|p|p[0].strftime("%Y年%m月")}
    gon.all_data = @payments.map{|p|p[1]}

    @month_payments = Payment.joins(:property, :contract, :user)
                      .where(user_id: current_user.id, paid_date: Time.now.all_month)
                      .group('building').sum('contracts.rent')

    gon.month_labels = @month_payments.map{|p|p[0]}
    gon.month_data = @month_payments.map{|p|p[1]}

    occupant_rooms = Room.joins(:contracts).where(user_id: current_user.id).where(Contract.arel_table[:end_date].gteq Date.today)
    gon.occupancy_rate = ((occupant_rooms.count.to_f / Room.all.count.to_f)*100).round(2)
  end

  def index
    @property = current_user.property.all
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
    params.require(:property).permit(:postal_code, :prefecture, :city, :address_line, :building, :total_units, :building_year, :property_type, :business_entity, :land_area, :building_area).merge(user_id: current_user.id)
  end
end

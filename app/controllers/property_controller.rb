class PropertyController < ApplicationController
  before_action :find_params, only: [:show, :edit, :update, :destroy]

  def summary
    @payments = Payment.joins(:property, :user)
                .where(user_id: current_user.id, not_paid:'0')
                .order(:paid_date)
                .group('paid_date')
                .sum('amounts')
                
    gon.all_labels = @payments.map{|p|p[0].strftime("%Y年%m月")}
    gon.all_data = @payments.map{|p|p[1]}

    @month_payments = Payment.joins(:property, :user)
                      .where(user_id: current_user.id, paid_date: Time.now.all_month, not_paid:'0')
                      .group('building').sum('amounts')

    gon.month_labels = @month_payments.map{|p|p[0]}
    gon.month_data = @month_payments.map{|p|p[1]}

    @occupant_rooms = Room.joins(:contracts).where(user_id: current_user.id)
                      .where(Contract.arel_table[:end_date].gteq Date.today)

    gon.occupancy_rate = ((@occupant_rooms.count.to_f / Room.all.count.to_f)*100).round(2)

    @monthly_income = Payment.joins(:contract, :user)
                      .where(user_id: current_user.id, paid_date: Time.now.all_month, not_paid:'0')
                      .sum('contracts.rent')

    @not_paid = Payment.joins(:user)
                .where(not_paid:'1',user_id: current_user.id, paid_date: Time.now.all_month)
                .count

    @not_paid_all = Payment.joins(:user)
                  .where(not_paid:'1',user_id: current_user.id)
                  .count

    @renew_contract = Contract.joins(:user)
                      .where(user_id: current_user.id)
                      .where(Contract.arel_table[:end_date].lt(Date.today + 90))
                      .count
  end

  def index
    @property = current_user.property.all
  end

  def show
  end

  def new
    @property_company = PropertyCompany.new
  end

  def create
    @property_company = PropertyCompany.new(property_params)
    if @property_company.valid?
      @property_company.save
      redirect_to property_index_path
    else
      render :new
    end
  end

  def edit
    @property_company = PropertyCompany.new(property: @property)
  end

  def update
    @property_company = PropertyCompany.new(property_params, property: @property)
    if @property_company.valid?
      @property_company.update
      redirect_to @property
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
    params.require(:property_company).permit(:postal_code, :prefecture, :city, :address_line, :building, :total_units, :building_year, :property_type, :business_entity, :land_area, :building_area, :name, :department, :sales_person, :telephone, :email).merge(user_id: current_user.id, management_company_id: params[:management_company_id], property_id: params[:id])
  end
end

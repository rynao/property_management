class PropertyController < ApplicationController
  before_action :find_params, only: [:show, :edit, :update, :destroy]

  def summary
    # 今月収入
    @monthly_income = Payment.joins(:contract, :user)
                              .where(user_id: current_user.id, paid_date: Time.now.all_month, not_paid:'0')
                              .sum('contracts.rent')

    # 契約更新対象
    @renew_contract = Contract.joins(:user)
                              .where(user_id: current_user.id)
                              .where("end_date <= ?",Date.today + 90)
                              .where("end_date >= ?",Date.today)
                              .count

    # 今月未納
    @not_paid = Payment.joins(:user)
                        .where(not_paid:'1',user_id: current_user.id, paid_date: Time.now.all_month)
                        .count

    # 累計未納
    @not_paid_all = Payment.joins(:user)
                            .where(not_paid:'1',user_id: current_user.id)
                            .count

    # 稼働状況
    @occupant_rooms = Room.joins(:contracts).where(user_id: current_user.id)
                          .where(Contract.arel_table[:end_date].gteq Date.today)

      gon.occupancy_rate = ((@occupant_rooms.count.to_f / Room.all.count.to_f)*100).round(2)

    # 月別家賃
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @month_payments = Payment.joins(:property, :user)
                              .where(user_id: current_user.id, paid_date: @month.all_month, not_paid:'0')
                              .group('building').sum('amounts')

      gon.month_labels = @month_payments.map{|p|p[0]}
      gon.month_data = @month_payments.map{|p|p[1]}

    # 過去1年家賃実績
    target_month = Date.today.beginning_of_month
    last_year = target_month - 1.year

    @payments = Payment.joins(:property, :user)
                      .where(user_id: current_user.id, not_paid:'0')
                      .where(Payment.arel_table[:paid_date].gteq last_year)
                      .order(:paid_date)
                      .group('paid_date')
                      .sum('amounts')
                
      gon.all_labels = @payments.map{|p|p[0].strftime("%Y年%m月")}
      gon.all_data = @payments.map{|p|p[1]}
  end

  def index
    @property = current_user.property.all.order(:building)
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
      flash.now[:errors] = @property_company.errors.full_messages.join(',').gsub(",","<br>")
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
      flash.now[:errors] = @property_company.errors.full_messages.join(',').gsub(",","<br>")
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

  def get_building_rents
    target_building = params[:property_id]
    target_month = Date.today.beginning_of_month
    last_year = target_month - 1.year
    if target_building == '0'
      @payments = Payment.joins(:property, :user)
                          .where(user_id: current_user.id, not_paid:'0')
                          .where(Payment.arel_table[:paid_date].gteq last_year)
                          .order(:paid_date)
                          .group('paid_date')
                          .sum('amounts')
    else
      @payments = Payment.joins(:property, :user)
                          .where(user_id: current_user.id, not_paid:'0', property_id: target_building)
                          .where(Payment.arel_table[:paid_date].gteq last_year)
                          .order(:paid_date)
                          .group('paid_date')
                          .sum('amounts')
    end
    gon.all_labels = @payments.map{|p|p[0].strftime("%Y年%m月")}
    gon.all_data = @payments.map{|p|p[1]}
    render json: { labels: gon.all_labels, data: gon.all_data}
  end

  private

  def find_params
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property_company).permit(:postal_code, :prefecture, :city, :address_line, :building, :total_units, :building_year, :property_type, :business_entity, :land_area, :building_area, :name, :department, :sales_person, :telephone, :email).merge(user_id: current_user.id, management_company_id: params[:management_company_id], property_id: params[:id])
  end
end

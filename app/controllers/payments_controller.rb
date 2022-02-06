class PaymentsController < ApplicationController
  before_action :find_params, only: [:show, :edit, :update, :destroy]

  def index
    # sql= "
    #   SELECT pr.building, pa.paid_date, SUM(rent) AS sumrent
    #   FROM payments pa
    #   LEFT OUTER JOIN rooms r ON pa.room_id = r.id
    #   JOIN properties pr ON pa.property_id = pr.id
    #   JOIN contracts c ON pa.contract_id = c.id
    #   GROUP BY paid_date, pr.id 
    #   ORDER BY pr.id, paid_date"
    # smr = ActiveRecord::Base.connection.select_all(sql)
    # @summary = smr.to_a

    @payments = Payment.joins(:property, :contract, :user)
                .where(user_id: current_user.id).order(:paid_date)
                .group('paid_date').sum('contracts.rent')
                

    @month_payments = Payment.joins(:property, :contract, :user)
                      .where(user_id: current_user.id, paid_date: Time.now.all_month)
                      .group('building').sum('contracts.rent')

    gon.month_labels = @month_payments.map{|p|p[0]}
    gon.month_data = @month_payments.map{|p|p[1]}

    gon.all_labels = @payments.map{|p|p[0].strftime("%Y年%m月")}
    gon.all_data = @payments.map{|p|p[1]}

  end

  def new
    @payment = Payment.new

  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      redirect_to payment_path(@payment.id)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @payment.update(payment_params)
      redirect_to payment_path(@payment.id)
    else
      render :edit
    end
  end

  def destroy
    if @payment.destroy
      redirect_to payments_path
    else
      render :show
    end
  end

  private

  def find_params
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:paid_date, :paid).merge(property_id: params[:property_id], room_id: params[:room_id], contract_id: params[:contract_id], user_id: current_user.id)
  end
end

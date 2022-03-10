class PaymentsController < ApplicationController
  before_action :find_params, only: [:show, :edit, :update, :destroy]

  def index
    @payments = Payment.joins(:property, :user)
                .where(user_id: current_user.id).order(:paid_date)
                .group('paid_date').sum('amounts')
                

    @month_payments = Payment.joins(:property, :user)
                      .where(user_id: current_user.id, paid_date: Time.now.all_month)
                      .group('building').sum('amounts')

    gon.month_labels = @month_payments.map{|p|p[0]}
    gon.month_data = @month_payments.map{|p|p[1]}

    gon.all_labels = @payments.map{|p|p[0].strftime("%Y年%m月")}
    gon.all_data = @payments.map{|p|p[1]}

    @index = Payment.joins(:property, :contract, :user)
    .where(user_id: current_user.id).order(paid_date: :DESC).order(:building)

  end

  def new
    # @payment = Payment.new
    @contracts = current_user.contracts.where("end_date >= ?",Date.today)
    @form = Form::PaymentCollection.new
  end

  def create
    # @payment = Payment.new(payment_params)
    # if @payment.save
    #   redirect_to payments_path
    # else
    #   render :new
    # end
    @contracts = current_user.contracts.where("end_date >= ?",Date.today)
    @form = Form::PaymentCollection.new(payment_collection_params)
    if @form.save
      redirect_to payments_path
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
      redirect_to payments_path
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
    params.require(:payment).permit(:paid_date, :not_paid, :amounts).merge(property_id: params[:property_id], room_id: params[:room_id], contract_id: params[:contract_id], user_id: current_user.id)
  end

  def payment_collection_params
    params.require(:form_payment_collection)
    .permit(payments_attributes: [:paid_date, :not_paid, :amounts, :property_id, :room_id, :contract_id, :user_id, :checked])
  end
end

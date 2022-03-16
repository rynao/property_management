class PaymentsController < ApplicationController
  before_action :find_params, only: [:show, :edit, :update, :destroy]

  def index
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @building_payments = Payment.joins(:property, :user)
                      .where(user_id: current_user.id, paid_date: @month.all_month)
                      .group('building').sum('amounts')

    @all_payments = Payment.joins(:property, :room, :contract, :user)
              .where(user_id: current_user.id, paid_date: @month.all_month).order(:building).order(:name)

    @not_paid = Payment.where(not_paid: true)
  end

  def new
    @contracts = current_user.contracts.where("end_date >= ?",Date.today)
    @form = Form::PaymentCollection.new
    @month = params[:paid_date] ? Date.parse(params[:paid_date]) : Time.zone.today
  end

  def create
    @contracts = current_user.contracts.where("end_date >= ?",Date.today)
    @form = Form::PaymentCollection.new(payment_collection_params)
    if @form.save
      @month = Payment.last.paid_date
      redirect_to payments_path(month:@month)
    else
      @form = Form::PaymentCollection.new
      @month = params[:paid_date] ? Date.parse(params[:paid_date]) : Time.zone.today
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @payment.update(payment_params)
      redirect_to payments_path(month:@payment.paid_date)
    else
      render :edit
    end
  end

  def destroy
    if @payment.destroy
      redirect_to payments_path(month:@payment.paid_date)
    else
      render payments_path(month:@payment.paid_date)
    end
  end

  private

  def find_params
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:paid_date, :not_paid, :amounts, :property_id, :room_id, :contract_id).merge(user_id: current_user.id)
  end

  def payment_collection_params
    params.require(:form_payment_collection)
    .permit(payments_attributes: [:paid_date, :not_paid, :amounts, :property_id, :room_id, :contract_id, :user_id, :checked])
  end
end

class PaymentsController < ApplicationController
  before_action :find_params, only: [:show, :edit, :update, :destroy]

  def index
    @payments = Payment.includes(:property, :room, :contract)
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
    params.require(:payment).permit(:paid_date, :paid, :property_id, :room_id, :contract_id)
  end
end

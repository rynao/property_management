class ContractsController < ApplicationController
  before_action :find_params, only: [:show, :edit, :update, :destroy]

  def index
    @contracts = Contract.includes(:property, :room)
  end

  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)
    if @contract.save
      redirect_to contract_path(@contract.id)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @contract.update(contract_params)
      redirect_to contract_path(@contract.id)
    else
      render :edit
    end
  end

  def destroy
    if @contract.destroy
      redirect_to contracts_path
    else
      render :show
    end
  end

  private

  def find_params
    @contract = Contract.find(params[:id])
  end

  def contract_params
    params.require(:contract).permit(:start_date, :end_date, :rent, :property_id, :room_id)
  end
end

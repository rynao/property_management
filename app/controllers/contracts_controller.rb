class ContractsController < ApplicationController
  before_action :find_params, only: [:show, :edit, :update, :destroy]

  def index
    @contracts = current_user.contracts.joins(:property, :room)
                              .where("end_date >= ?",Date.today)
                              .order(:building).order(:name)

    @old_contracts = current_user.contracts.joins(:property, :room)
                              .where("end_date < ?",Date.today)
                              .order(:building).order(:name)
  end

  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)
    if @contract.save
      redirect_to contracts_path
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
      redirect_to contracts_path
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
    params.require(:contract).permit(:start_date, :end_date, :rent, :contractor, :management_cost).merge(property_id: params[:property_id], room_id: params[:room_id], user_id: current_user.id)
  end
end

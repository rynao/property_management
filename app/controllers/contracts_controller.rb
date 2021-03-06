class ContractsController < ApplicationController
  before_action :find_params, only: [:show, :edit, :update, :destroy]

  def index
    @renew_contracts = current_user.contracts.joins(:property, :room)
                                    .where("end_date <= ?",Date.today + 90)
                                    .where("end_date >= ?",Date.today)
                                    .order(:end_date)

    @contracts = current_user.contracts.joins(:property, :room)
                              .where("end_date >= ?",Date.today)
                              .order(:building).order(:name)
    @property = current_user.property.where(sold:nil).or(current_user.property.where(sold:0))
    @property_count = current_user.property.where(sold:nil).or(current_user.property.where(sold:0)).count

    @old_contracts = current_user.contracts.joins(:property, :room)
                              .where("end_date < ?",Date.today)
                              .order(:building).order(:name)
  end

  def new
    @contract = Contract.new(property_id: params[:property_id], room_id: params[:room_id])
  end

  def create
    @contract = Contract.new(contract_params)
    if @contract.save
      redirect_to contracts_path
    else
      flash.now[:errors] = @contract.errors.full_messages.join(',').gsub(",","<br>")
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
      flash.now[:errors] = @contract.errors.full_messages.join(',').gsub(",","<br>")
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

class ContractsController < ApplicationController
  # protect_from_forgery
  before_action :find_params, only: [:show, :edit, :update, :destroy]

  def index
    @contracts = Contract.includes(:property, :room)
  end

  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)
    binding.pry
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

  # Ajax処理を行う処理
  def get_rooms
    rooms = Room.where(property_id: params[:property_id])
    render json:{ rooms: rooms }
  end

  private

  def find_params
    @contract = Contract.find(params[:id])
  end

  def contract_params
    params.require(:contract).permit(:start_date, :end_date, :rent).merge(property_id: params[:property_id], room_id: params[:room_id],user_id: current_user.id)
  end
end

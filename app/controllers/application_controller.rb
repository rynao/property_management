class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  # Ajax処理を行う処理
  def get_rooms
    rooms = Room.where(property_id: params[:property_id])
    render json:{ rooms: rooms }
  end

  def get_contracts
    contracts = Contract.where(room_id: params[:room_id])
    render json:{ contracts: contracts }
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end

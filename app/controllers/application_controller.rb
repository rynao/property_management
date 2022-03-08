class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  # Ajax処理を行う処理
  def get_rooms
    rooms = Room.where(property_id: params[:property_id])
    render json:{ rooms: rooms }
  end

  def get_contracts
    contracts = Contract.where(room_id: params[:room_id]).order(end_date: "DESC")
    render json:{ contracts: contracts }
  end

  def get_amounts
    contract = Contract.find(params[:contract_id])
    render json:{ amounts: contract.rent }
  end

  def get_copy_contracts
    @contracts = Contract.where(id: params[:id].split(','))
    forms = []
    @contracts.length.times do
      form = Form::PaymentCollection.new
      forms << form
    end
    binding.pry
    partial = render_to_string(partial:'payments/copy_payments_form', :locals => { contracts: @contracts, form: @form })
    # render json:{ contracts: contracts }
    render json:{partial: partial}
    # render partial: 'payments/payments_form', locals: {form: @contracts}
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end

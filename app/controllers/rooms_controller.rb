class RoomsController < ApplicationController
  before_action :find_params, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = current_user.rooms.includes(:property)
  end

  def new
    @property = Property.find(params[:property_id])
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to "/property/#{@room.property.id}"
    else
      render :new
    end
  end

  def show
  end

  def edit
    @property = Property.find(params[:property_id])
  end

  def update  
    if @room.update(room_params)
      redirect_to property_room_path(@room.id)
    else
      render :edit
    end
  end

  def destroy
    if @room.destroy
      redirect_to property_path(@room.property.id)
    else
      render :show
    end
  end

  private

  def find_params
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name).merge(property_id: params[:property_id], user_id: current_user.id)
  end

end

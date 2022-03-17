class RoomsController < ApplicationController
  before_action :find_params, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.joins(:property, :user)
                  .where(user_id: current_user.id)
                  .order("properties.building")
                  .order("rooms.name")
  end

  def new
    @property = Property.find(params[:property_id])
    @form = Form::RoomCollection.new
  end

  def create
    @property = Property.find(params[:property_id])
    @form = Form::RoomCollection.new(room_collection_params)
    if @form.save
      redirect_to property_path(@property.id)
    else
      flash.now[:errors] = @form.errors.gsub(",","<br>")
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
      redirect_to property_path(@room.property.id)
    else
      flash.now[:errors] = @room.errors.full_messages.join(',').gsub(",","<br>")
      @property = Property.find(params[:property_id])
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
    params
    .require(:room)
    .permit(:name, :layout, :room_size, :direction)
    .merge(property_id: params[:property_id], user_id: current_user.id)
  end

  def room_collection_params
    params
      .require(:form_room_collection)
      .permit(rooms_attributes:  [:name, :layout, :room_size, :direction, :property_id, :user_id])
  end
end

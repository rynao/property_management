class PropertyController < ApplicationController
  def index
    @property = Property.all
  end

  def show
    @property = Property.find(params[:id])
  end
end

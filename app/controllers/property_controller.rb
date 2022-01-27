class PropertyController < ApplicationController
  def index
    @property = Property.all
  end
end

class Form::RoomCollection < Form::Base
  FORM_COUNT = 1 #ここで、作成したい登録フォームの数を指定
  attr_accessor :rooms

  def initialize(attributes = {})
    super attributes
    self.rooms = FORM_COUNT.times.map { Room.new() } unless self.rooms.present?
  end

  def rooms_attributes=(attributes)
    self.rooms = attributes.map { |_, v| Room.new(v) }
  end

  def save
    success = true
    @errors =[]
    Room.transaction do
      @rooms.each do |room|
        unless room.save
          success = false
          @errors << room.errors.full_messages
        end
      end
      unless success
        raise ActiveRecord::Rollback
      end
    end
    return success
  end
end
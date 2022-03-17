class Form::PaymentCollection < Form::Base
  FORM_COUNT = 1 #ここで、作成したい登録フォームの数を指定
  attr_accessor :payments

  validates :paid_date, presence: true
  validates :amounts,  numericality: {only_integer: true}

  def initialize(attributes = {})
    super attributes
    self.payments = FORM_COUNT.times.map { Payment.new() } unless self.payments.present?
  end

  def payments_attributes=(attributes)
    self.payments = attributes.map { |_, v| Payment.new(v) }
  end

  def save
    success = true
    @errors =[]
    Payment.transaction do
      # return false unless valid?
      @payments.each do |payment|
        if payment.checked
          unless payment.save
            success = false
          @errors << payment.errors.full_messages
          end
        end
      end
      unless success
        @errors = @errors.join(',')
        raise ActiveRecord::Rollback
      end
    end
    return success
  end
end
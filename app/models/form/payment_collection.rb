class Form::PaymentCollection < Form::Base
  FORM_COUNT = 1 #ここで、作成したい登録フォームの数を指定
  attr_accessor :payments

  def initialize(attributes = {})
    super attributes
    self.payments = FORM_COUNT.times.map { Payment.new() } unless self.payments.present?
  end

  def payments_attributes=(attributes)
    self.payments = attributes.map { |_, v| Payment.new(v) }
  end

  def save
    Payment.transaction do
      self.payments.map do |payment|
        if payment.checked
          payment.save
        end
      end
    end
      return true
    rescue => e
      return false
    end
end
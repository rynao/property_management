class Form::PaymentCollection < Form::Base
  FORM_COUNT = 2 #ここで、作成したい登録フォームの数を指定
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
      self.payments.map(&:save!)
    end
      return true
    rescue => e
      return false
  end
end
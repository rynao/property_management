class PropertyCompany
  include ActiveModel::Model
  include ActiveRecord::AttributeAssignment
  attr_accessor(
    :postal_code,
    :prefecture,
    :city,
    :address_line,
    :building,
    :total_units,
    :building_year,
    :property_type,
    :business_entity,
    :land_area,
    :building_area,
    :user_id,
    :name,
    :department,
    :sales_person,
    :telephone,
    :email
  )
  
  with_options presence: true do
    validates :prefecture
    validates :city
    validates :building
    validates :business_entity
    validates :user_id
  end
  validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は###-####（半角）の形式で入力してください'}, allow_blank: true
  validates :total_units, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000, message: 'は1以上の半角整数で入力してください'}, allow_blank: true
  validates :telephone, format: {with: /\A\d{10,11}\z/, message: 'は10~11桁の半角数字で入力してください'}, allow_blank: true
  validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'は有効なメールアドレス形式で入力してください'}, allow_blank: true

  def save
    unless :name.present?
      management = ManagementCompany.create(name: name, department: department, sales_person: sales_person, telephone: telephone, email: email, user_id: user_id)
      Property.create(postal_code: postal_code, prefecture: prefecture, city: city, address_line: address_line, building: building,total_units: total_units, building_year: building_year, property_type:property_type, business_entity: business_entity, land_area: land_area, building_area: building_area, user_id: user_id, management_company_id: management.id)
    else
      Property.create(postal_code: postal_code, prefecture: prefecture, city: city, address_line: address_line, building: building,total_units: total_units, building_year: building_year, property_type:property_type, business_entity: business_entity, land_area: land_area, building_area: building_area, user_id: user_id)
    end
  end
end
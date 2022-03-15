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
    :email,
    :management_company_id,
    :property_id
  )
  
  with_options presence: true do
    validates :prefecture
    validates :city
    validates :building
    validates :property_type
    validates :business_entity
    validates :user_id
  end
  validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は###-####（半角）の形式で入力してください'}, allow_blank: true
  validates :total_units, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000, message: 'は1以上の半角整数で入力してください'}, allow_blank: true
  validates :telephone, format: {with: /\A\d{10,11}\z/, message: 'は10~11桁の半角数字で入力してください'}, allow_blank: true
  validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'は有効なメールアドレス形式で入力してください'}, allow_blank: true
  validates :land_area, numericality: {greater_than_or_equal_to: 1.00, message: 'は1.00以上の半角数値で入力してください'}, allow_blank: true
  validates :building_area, numericality: {greater_than_or_equal_to: 1.00, message: 'は1.00以上の半角数値で入力してください'}, allow_blank: true
  validates :name, presence: true, if: :present_columns?

  # formオブジェクトで編集可能にするために必要
  def initialize(attributes = nil, property: Property.new)
    @property = property
    if @property.management_company.nil?
      attributes ||= default_attributes_1
    else
      attributes ||= default_attributes_2
    end
    super(attributes)
  end

  def save
    if name.blank?
      Property.create(postal_code: postal_code, prefecture: prefecture, city: city, address_line: address_line, building: building,total_units: total_units, building_year: building_year, property_type:property_type, business_entity: business_entity, land_area: land_area, building_area: building_area, user_id: user_id)
    else
      management = ManagementCompany.create(name: name, department: department, sales_person: sales_person, telephone: telephone, email: email, user_id: user_id)
      Property.create(postal_code: postal_code, prefecture: prefecture, city: city, address_line: address_line, building: building,total_units: total_units, building_year: building_year, property_type:property_type, business_entity: business_entity, land_area: land_area, building_area: building_area, user_id: user_id, management_company_id: management.id)
    end
  end

  def update
    if management_company_id.present? && name.present?
      management = ManagementCompany.find(management_company_id)
      management.update(name: name, department: department, sales_person: sales_person, telephone: telephone, email: email, user_id: user_id)
      property = Property.find(property_id)
      property.update(postal_code: postal_code, prefecture: prefecture, city: city, address_line: address_line, building: building,total_units: total_units, building_year: building_year, property_type:property_type, business_entity: business_entity, land_area: land_area, building_area: building_area, management_company_id: management.id)
    elsif management_company_id.present?
      management = ManagementCompany.find(management_company_id)
      management.destroy
      property = Property.find(property_id)
      property.update(postal_code: postal_code, prefecture: prefecture, city: city, address_line: address_line, building: building,total_units: total_units, building_year: building_year, property_type:property_type, business_entity: business_entity, land_area: land_area, building_area: building_area, management_company_id: nil)
    else
      management = ManagementCompany.create(name: name, department: department, sales_person: sales_person, telephone: telephone, email: email, user_id: user_id)
      property = Property.find(property_id)
      property.update(postal_code: postal_code, prefecture: prefecture, city: city, address_line: address_line, building: building,total_units: total_units, building_year: building_year, property_type:property_type, business_entity: business_entity, land_area: land_area, building_area: building_area, management_company_id: management.id)
    end
  end

  private

  def present_columns?
    department.present? || sales_person.present? ||telephone.present? || email.present?
  end

  def default_attributes_1
    {
    postal_code: @property.postal_code,
    prefecture: @property.prefecture,
    city: @property.city,
    address_line: @property.address_line,
    building: @property.building,
    total_units: @property.total_units,
    building_year: @property.building_year,
    property_type: @property.property_type,
    business_entity: @property.business_entity,
    land_area: @property.land_area,
    building_area: @property.building_area,
    user_id: @property.user_id,
    }
  end

  def default_attributes_2
    {
    postal_code: @property.postal_code,
    prefecture: @property.prefecture,
    city: @property.city,
    address_line: @property.address_line,
    building: @property.building,
    total_units: @property.total_units,
    building_year: @property.building_year,
    property_type: @property.property_type,
    business_entity: @property.business_entity,
    land_area: @property.land_area,
    building_area: @property.building_area,
    user_id: @property.user_id,
    name: @property.management_company.name,
    department: @property.management_company.department,
    sales_person: @property.management_company.sales_person,
    telephone: @property.management_company.telephone,
    email: @property.management_company.email,
    management_company_id: @property.management_company_id
    }
  end

end
FactoryBot.define do
  factory :property_company do
    postal_code { Faker::Address.zip }
    prefecture { '神奈川県' }
    city { Faker::Address.city }
    address_line { Faker::Address.street_address }
    building { '横浜ビル' }
    total_units { Faker::Number.digit }
    building_year { Faker::Date.between(from: '1950-01-01', to: '2030-12-31') }
    purchase_date { Faker::Date.between(from: '1950-01-01', to: '2030-12-31') }
    property_type { '1棟マンション' }
    business_entity { '法人' }
    land_area { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    building_area { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    sold { true }
    name { '管理会社' }
    department {'東日本本部'}
    sales_person { '山田太郎'}
    telephone {'09012345678'}
    email { Faker::Internet.email }
  end
end

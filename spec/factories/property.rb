FactoryBot.define do
  factory :property do
    postal_code { Faker::Address.zip }
    prefecture { '神奈川県' }
    city { Faker::Address.city }
    address_line { Faker::Address.street_address }
    building { '横浜ビル' }
    total_units { Faker::Number.digit }
    building_year { Faker::Date.between(from: '1050-01-01', to: '2030-12-31') }
    property_type { '1棟マンション' }
    business_entity { '法人' }
    land_area { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    building_area { Faker::Number.decimal(l_digits: 3, r_digits: 2) }

    association :user
    association :management_company
  end
end

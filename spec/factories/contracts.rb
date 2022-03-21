FactoryBot.define do
  factory :contract do
    start_date { Faker::Date.between(from: '1950-01-01', to: '2030-12-31') }
    end_date { Faker::Date.between(from: '1950-01-01', to: '2030-12-31') }
    rent {'100000'}
    management_cost {'5000'}
    contractor { '山田 太郎' }
    association :user
    association :property
    association :room
  end
end

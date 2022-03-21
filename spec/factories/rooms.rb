FactoryBot.define do
  factory :room do
    name {'1001'}
    layout {'1LDK'}
    room_size { Faker::Number.decimal(l_digits: 2, r_digits: 1) }
    direction { '南東' }
  end
end

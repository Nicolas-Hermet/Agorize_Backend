FactoryBot.define do
  factory :building do
    reference { Faker::Number.unique.number(8) }
    address { Faker::address.street_address }
    zip_code { Faker::address.postcode }
    city { Faker::address.city }
    country { Faker::address.country }
    manager_name { Faker::Name.name }
  end
end

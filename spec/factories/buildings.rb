# frozen_string_literal: true

FactoryBot.define do
  factory :building do
    reference { Faker::Number.unique.number(digits: 8) }
    address { Faker::Address.street_address }
    zip_code { Faker::Address.postcode }
    city { Faker::Address.city }
    country { Faker::Address.country }
    manager_name { Faker::Name.name }
  end
end

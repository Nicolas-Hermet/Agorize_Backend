# frozen_string_literal: true

FactoryBot.define do
  factory :person do
    reference { Faker::Number.unique.number(digits: 8).to_s }
    email { Faker::Internet.email }
    home_phone_number { Faker::PhoneNumber.cell_phone_in_e164 }
    mobile_phone_number { Faker::PhoneNumber.cell_phone_in_e164 }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    address { Faker::Address.street_address }
  end
end

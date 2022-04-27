# frozen_string_literal: true

FactoryBot.define do
  factory :history do
    column { Faker::Lorem.word }
    value { Faker::Lorem.word }
    memorable { create(%i[building person].sample) }
  end
end

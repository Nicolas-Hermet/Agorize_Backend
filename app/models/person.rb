class Person < ApplicationRecord
  has_many :histories, as: :memorable
end

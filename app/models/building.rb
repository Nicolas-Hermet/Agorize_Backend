class Building < ApplicationRecord
  has_many :histories, as: :memorable
end

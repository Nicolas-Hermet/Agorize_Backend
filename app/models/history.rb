class History < ApplicationRecord
  belongs_to :memorable, polymorphic: true
end
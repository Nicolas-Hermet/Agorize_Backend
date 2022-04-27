# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  before_update :record_history

  def record_history
    return if instance_of?(History)

    attributes.each_key do |key|
      old_value = send("#{key}_was".to_sym)
      changed = send("#{key}_changed?".to_sym)
      History.create(column: key, value: old_value, memorable: self) if old_value && changed
    end
  end
end

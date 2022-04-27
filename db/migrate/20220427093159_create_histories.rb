class CreateHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :histories do |t|
      t.string  :column
      t.string  :value
      t.references :memorable, polymorphic: true
      t.timestamps
    end

    add_index :histories, %i[memorable_type memorable_id]
  end
end

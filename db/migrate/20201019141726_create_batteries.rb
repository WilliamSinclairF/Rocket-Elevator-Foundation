class CreateBatteries < ActiveRecord::Migration[5.2]
  def change
    create_table :batteries do |t|
      t.integer :building_id
      t.integer :battery_id
      t.string :type
      t.string :status
      t.integer :employee_id
      t.date :date_of_commissioning
      t.date :date_of_last_inspection
      t.string :certificate_of_operations
      t.string :information
      t.string :notes

      t.timestamps
    end
  end
end

class CreateAlerts < ActiveRecord::Migration[5.2]
  def change
    create_table :alerts do |t|
      t.integer :delay
      t.string :description
      t.time   :expiery_at
      t.string :status
      t.string :completed_at

      t.timestamps
    end
  end
end

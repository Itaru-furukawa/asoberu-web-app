class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.string :name
      t.integer :member_number
      t.string :password
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end

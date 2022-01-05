class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.bigint :schedule_id, index: false
      t.bigint :member_id, index: false
      t.string :name
      t.bigint :start
      t.bigint :end
      t.boolean :timed
      t.string :color
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end

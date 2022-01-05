class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.bigint :schedule_id, index: false
      t.bigint :member_id, index: false
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end

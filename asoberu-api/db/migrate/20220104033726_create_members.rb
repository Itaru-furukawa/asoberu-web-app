class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.references :schedule, foreign_key: true, index: false
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

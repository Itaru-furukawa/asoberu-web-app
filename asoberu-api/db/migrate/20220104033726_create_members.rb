class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.references :schedule, type: :bigint, foreign_key: true, index: false
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end

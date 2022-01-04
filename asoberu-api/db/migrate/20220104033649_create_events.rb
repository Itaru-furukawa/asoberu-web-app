class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :schedule, foreign_key: true, index: false
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end

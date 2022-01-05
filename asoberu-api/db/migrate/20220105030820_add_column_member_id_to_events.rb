class AddColumnMemberIdToEvents < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :events, :schedules, column: :schedule_id
    add_foreign_key :events, :members, column: :member_id
  end
end

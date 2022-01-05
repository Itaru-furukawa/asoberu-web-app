FactoryBot.define do
  factory :event do
    name { 'グーフィー 予定あり' }
    schedule_id { 1 }
    member_id { 1 }
    start { 1643212800000 }
    timed { true }
    color { '#3F51B5' }
  end
end

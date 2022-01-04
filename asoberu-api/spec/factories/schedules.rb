FactoryBot.define do
  factory :schedule do
    name { '忘年会' }
    member_number { 4 }
    password { 'password' }
    start_date { '2022-01-12 00:00' }
    end_date { '2022-01-19 23:59' }
  end
end

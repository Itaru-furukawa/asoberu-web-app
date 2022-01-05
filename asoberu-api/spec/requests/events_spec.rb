require 'rails_helper'

describe 'event #index' do
  let!(:events) { create_list(:event, 10, end: 1643224500000) }
  
  context '取得したいスケジュールのパスワードが正しいとき' do
    it 'イベントが取得できること' do
      get '/api/v1/events/2?password=password'
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
    end

    it 'イベントが取得できないこと' do
      get '/api/v1/events/2?password=hoge'
      json = JSON.parse(response.body)
      expect(response.status).to eq(404)
    end
  end
end

describe 'event #get' do
  let!(:events) { create_list(:event, 10, end: 1643224500000) }
  
  context '取得したいスケジュールのパスワードが正しいとき' do
    it 'イベントが取得できること' do
      get '/api/v1/events/2?password=password'
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
    end

    it 'イベントが取得できないこと' do
      get '/api/v1/events/2?password=hoge'
      json = JSON.parse(response.body)
      expect(response.status).to eq(404)
    end
  end
end

# describe 'event #post' do
#   context 'postしたとき' do
#     it '該当するスケジュールが取得できること' do
#       post '/api/v1/events', params: { 
#         schedule: {
#           name: '忘年会',
#           member_number: 4,
#           password: 'password',
#           start_date: '2022-01-12 00:00',
#           end_date: '2022-01-19 23:59' 
#         }
#       }
#       expect(Schedule.find(1).present?).to eq(true)
#     end
#   end
# end

# describe 'event #put' do
#   let!(:events) { create_list(:schedule, 10) }
#   context '正しいパスワードでスケジュール名を変更した時' do
#     it '該当するスケジュールの変更されること' do
#       put '/api/v1/events/1?password=password', params: {
#         schedule: {
#           name: '新年会'
#         }
#       }
#       expect(response.status).to eq(200)
#       expect(Schedule.find(1).name).to eq('新年会')
#     end
#   end
#   context '不正なパスワードでスケジュール名を変更した時' do
#     it '該当するスケジュールの変更されないこと' do
#       put '/api/v1/events/1?password=invalid', params: {
#         schedule: {
#           name: '新年会'
#         }
#       }
#       expect(response.status).to eq(404)
#       expect(Schedule.find(1).name).to eq('忘年会')
#     end
#   end
# end

require 'rails_helper'

describe 'event #index' do
  let!(:schedule) { create(:schedule) }
  let!(:member) { create(:member) }
  let!(:events) { create_list(:event, 10, end: 1643224500000) }
  
  context '取得したいスケジュールのパスワードが正しいとき' do
    it 'イベントが取得できること' do
      get '/api/v1/events?schedule_id=1&password=password'
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
    end

    it 'イベントが取得できないこと' do
      get '/api/v1/events?schedule_id=1&password=invalid'
      json = JSON.parse(response.body)
      expect(response.status).to eq(404)
    end
  end
end

describe 'event #get' do
  let!(:schedule) { create(:schedule) }
  let!(:member) { create(:member) }
  let!(:events) { create_list(:event, 10, end: 1643224500000) }
  
  context '取得したいスケジュールのパスワードが正しいとき' do
    it 'イベントが取得できること' do
      get "/api/v1/events/1?password=password&member_id=1"
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
    end

    it 'イベントが取得できないこと' do
      get '/api/v1/events/1?password=invalid&member_id=1'
      json = JSON.parse(response.body)
      expect(response.status).to eq(404)
    end
  end
end

describe 'event #update' do
  let!(:schedule) { create(:schedule) }
  let!(:member) { create_list(:member, 10) }
  let!(:events) { create_list(:event, 10, end: 1643224500000) }
  
  context 'postしたとき' do
    it '該当するスケジュールが取得できること' do
      put '/api/v1/events/1?password=password', params: { 
        events: [
          {
            id: 1,
            name: 'ドナルド 予定あり',
            schedule_id: 1,
            member_id: 1,
            start: 1643212800000,
            timed: true,
            color: '#3F51B5'
          },
          {
            id: 2,
            name: 'ミッキー 予定あり',
            schedule_id: 1,
            member_id: 2,
            start: 1643212800000,
            timed: true,
            color: '#3F51B5'
          },
          {
            name: 'ミニー 予定あり',
            schedule_id: 1,
            member_id: 3,
            start: 1643212800000,
            timed: true,
            color: '#3F51B5'
          }
        ] 
      }
      expect(Event.all.count).to eq(11)
      expect(Event.find(1).name).to eq('ドナルド 予定あり')
      expect(Event.find(11).name).to eq('ミニー 予定あり')
    end
  end
end

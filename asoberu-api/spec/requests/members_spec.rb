require 'rails_helper'

describe 'Member #get' do
  let!(:schedule) { create_list(:schedule, 10) }
  let!(:members) { create_list(:member, 10) }
  
  context '取得したいメンバーのパスワードが正しいとき' do
    it 'メンバーが取得できること' do
      get '/api/v1/members?schedule_id=1&password=password'
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
    end

    it 'メンバーが取得できないこと' do
      get '/api/v1/members?schedule_id=1&password=invalid'
      json = JSON.parse(response.body)
      expect(response.status).to eq(404)
    end
  end
end

describe 'Member #post' do
  let!(:schedule) { create_list(:schedule, 10) }
  let!(:members) { create_list(:member, 10) }
  context 'postしたとき' do
    it '該当するメンバーリストが取得できること' do
      post '/api/v1/members?schedule_id=1&password=password', params: { 
        members: [
          {
            name: 'ミッキー',
            schedule_id: 1

          },
          {
            name: 'ミニー',
            schedule_id: 1
          }
        ]
      }
      expect(Member.all.count).to eq(12)
      expect(Member.find(12).name).to eq('ミニー')
    end
  end
end

describe 'Member #put' do
  let!(:schedule) { create_list(:schedule, 10) }
  let!(:members) { create_list(:member, 10) }
  context '正しいパスワードでメンバー名を変更した時' do
    it 'メンバー名が変更されること' do
      put '/api/v1/members/1?password=password', params: { 
        members: [
          {
            id: 1,
            name: 'ドナルド',
            schedule_id: 1

          },
          {
            id: 2,
            name: 'グーフィー',
            schedule_id: 1
          }
        ]
      }
      expect(response.status).to eq(200)
      expect(Member.find(1).name).to eq('ドナルド')
      expect(Member.find(2).name).to eq('グーフィー')
    end
  end
  context '不正なパスワードでメンバー名を変更した時' do
    it 'メンバー名が変更されないこと' do
      put '/api/v1/members/1?password=invalid', params: { 
        members: [
          {
            name: 'ミッキー',
            schedule_id: 1
          },
          {
            name: 'ミニー',
            schedule_id: 1
          }
        ]
      }
      expect(response.status).to eq(404)
      expect(Member.find(1).name).to eq('ミッキー')
      expect(Member.find(2).name).to eq('ミッキー')
    end
  end
end

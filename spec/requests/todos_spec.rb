require 'rails_helper'

RSpec.describe TodosController, type: :request do
  describe '#index' do
    before { 3.times { create(:todo) } }

    it 'HTTP ステータスコード 200 が返る' do
      get '/todos'
      expect(response.status).to eq 200
    end

    it 'todo が作成された数だけ JSON 形式で返る' do
      get '/todos'
      jsons = JSON.parse(response.body)
      expect(jsons.count).to eq 3
    end

    it '出力される JSON のキーが仕様通りである' do
      get '/todos'
      jsons = JSON.parse(response.body)
      expect(jsons[0].keys).to include('id', 'title', 'text', 'created_at')
    end

    it '返す JSON に、作成した todo の内容が正しく反映されている' do
      get '/todos'
      jsons = JSON.parse(response.body)
      todo = Todo.order(:created_at).first
      expect(jsons[0]['id']).to eq todo.id
      expect(jsons[0]['title']).to eq todo.title
      expect(jsons[0]['text']).to eq todo.text
      expect(jsons[0]['created_at']).to eq todo.created_at.as_json
    end
  end
end

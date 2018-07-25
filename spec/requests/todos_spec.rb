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
      json = JSON.parse(response.body)
      expect(json.count).to eq 3
    end

    it '返す JSON が、配列である' do
      get '/todos'
      json = JSON.parse(response.body)
      expect(json).to be_an_instance_of(Array)
    end
  end

  describe '#create' do
    let(:todo_params) { { title: 'title', text: 'text' } }

    it 'HTTP ステータスコード 201 が返る' do
      post '/todos', params: todo_params
      expect(response.status).to eq 201
    end

    it 'todo を新規作成する' do
      expect { post '/todos', params: todo_params }.to change { Todo.count }.by(1)
    end

    it '返す JSON が、ハッシュである' do
      post '/todos', params: todo_params
      json = JSON.parse(response.body)
      expect(json).to be_an_instance_of(Hash)
    end
  end
end

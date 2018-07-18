require 'rails_helper'

RSpec.describe TodosController, type: :request do
  describe '#index' do
    before { 3.times { create(:todo) } }

    it 'HTTP ステータスコード 200 が返る' do
      get '/todos'
      expect(response.status).to eq 200
    end

    it '返す JSON に、作成した todo の内容が正しく反映されている' do
      get '/todos'
      todo = Todo.order(:created_at)
      expected_response = [
        {
          id: todo.first.id,
          title: todo.first.title,
          text: todo.first.text,
          created_at: todo.first.created_at.as_json,
        },
        {
          id: todo.second.id,
          title: todo.second.title,
          text: todo.second.text,
          created_at: todo.second.created_at.as_json,
        },
        {
          id: todo.third.id,
          title: todo.third.title,
          text: todo.third.text,
          created_at: todo.third.created_at.as_json,
        },
      ]
      expect(response.body).to be_json_as(expected_response)
    end
  end
end

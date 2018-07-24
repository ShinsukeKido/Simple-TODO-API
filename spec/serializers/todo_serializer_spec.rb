require 'rails_helper'

RSpec.describe TodoSerializer, type: :serializer do
  let(:serializer) { described_class.new(todo) }
  let(:todo) { create(:todo) }

  let(:expected_response) do
    {
      id: todo.id,
      title: todo.title,
      text: todo.text,
      created_at: todo.created_at.as_json,
    }
  end

  it '返す JSON に、作成した todo の内容が正しく反映されている' do
    expect(serializer.to_json).to be_json_as expected_response
  end
end

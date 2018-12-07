require 'rails_helper'

describe 'Todo Items API creating endpoint' do
  describe 'POST /todo_items' do
    context 'successfully request' do
      it "returns todo_items created" do
        User.create(
          name: 'Teste', username: 'teste', email: 'foo@bar.com', password: 'teste'
        )

        expect {
          post api_v1_todo_items_path,
          params: {todo_item: { description: 'Foo bar' }},
          xhr: true
        }.to change(TodoItem, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body).size).not_to eq 0
        expect(JSON.parse(response.body)['description']).to eq 'Foo bar'
      end
    end

    context 'failed request' do
      it "failed todo_items created" do
        User.create(
          name: 'Teste', username: 'teste', email: 'foo@bar.com', password: 'teste'
        )

        expect {
          post api_v1_todo_items_path,
               params: {todo_item: { description: '' }},
               xhr: true
        }.not_to change(TodoItem, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body).size).to eq 1
        expect(JSON.parse(response.body)['description']).to include "Não pode ser branco"
      end
    end
  end
end

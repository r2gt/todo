require 'rails_helper'

describe 'Todo Items API editing endpoint' do
  before do
    @user = User.create(
      name: 'Teste', username: 'teste', email: 'foo@bar.com', password: 'teste'
    )

    @todo_item = @user.todo_items.create(description: 'Todo item a ser deletado')
  end

  describe 'PATCH /todo_items/:id' do
    context 'successfully request' do
      it "updates todo_item successfully" do
        patch api_v1_todo_item_path(@todo_item.id),
              params: { todo_item: { description: "Comprar Leite"}}.to_json,
              headers: basic_headers

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).dig("description")).to eql "Comprar Leite"
      end
    end

    context 'failed request' do
      it "updates todo_item" do
        patch api_v1_todo_item_path(@todo_item.id),
              params: { todo_item: { description: ""}}.to_json,
              headers: basic_headers

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['description']).to include "Não pode ser branco"
      end

      it "tries to edit another user's todo_item" do
        another_user = User.create(
          name: 'another', username: 'another', email: 'ano@ther.com', password: 'teste'
        )

        another_todo = another_user.todo_items.create(description: 'Todo item show')

        expect{
          patch api_v1_todo_item_path(another_todo.id),
              params: { todo_item: { description: "Comprar Leite"}}.to_json,
              headers: basic_headers
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end


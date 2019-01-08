require 'rails_helper'

describe 'Todo Items API editing endpoint' do
  before do
    user = User.create(
      name: 'Teste', username: 'teste', email: 'foo@bar.com', password: 'teste'
    )

    @todo_item = user.todo_items.create(description: 'Todo item a ser deletado')
  end

  describe 'PATCH /todo_items/:id' do
    context 'successfully request' do
      it "updates todo_item successfully" do
        patch api_v1_todo_item_path(@todo_item.id),
              params: { todo_item: { description: "Comprar Leite"}}

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).dig("description")).to eql "Comprar Leite"
      end
    end

    context 'failed request' do
      it "updates todo_item" do
        patch api_v1_todo_item_path(@todo_item.id),
              params: { todo_item: { description: ""}}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['description']).to include "Não pode ser branco"
      end
    end
  end
end


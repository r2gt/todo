require 'rails_helper'

describe 'Todo Items API deleting endpoint' do
  before do
    user = User.create(
      name: 'Teste', username: 'teste', email: 'foo@bar.com', password: 'teste'
    )

    @todo_item = user.todo_items.create(description: 'Todo item a ser deletado')
  end

  describe 'DELETE /todo_item/:id' do
    context 'successfully request' do
      it "deletes todo_item" do
        expect {
          delete api_v1_todo_item_path(@todo_item.id)

          expect(response).to have_http_status(:success)
        }.to change(TodoItem, :count).by(-1)
      end
    end

    context 'failed request' do
      it "doesn't deletes todo_item" do
        expect {
          delete api_v1_todo_item_path(666)
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end
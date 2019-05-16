require 'rails_helper'

describe 'Todo Items API deleting endpoint' do
  before do
    @board = user.owner_boards.create(name: 'Board 1')

    @todo_item = @board.todo_items.create(
      description: 'Todo item a ser deletado', user_id: @user.id
    )
  end

  describe 'DELETE /todo_item/:id' do
    context 'successfully request' do
      it "deletes todo_item" do
        expect {
          # require 'pry'; binding.pry

          delete api_v1_board_todo_item_path(@board, @todo_item), headers: basic_headers

          expect(response).to have_http_status(:success)
        }.to change(TodoItem, :count).by(-1)
      end
    end

    context 'failed request' do
      it "doesn't deletes todo_item" do
        expect {
          delete api_v1_board_todo_item_path(@board, 666), headers: basic_headers
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end

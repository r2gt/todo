require 'rails_helper'

describe 'Todo Items API showing endpoint' do
  describe 'GET /todo_items/:id' do
    before do
      @board = user.owner_boards.create(name: 'Board 1')

      @todo_item = @board.todo_items.create(
        description: 'Todo item show', user_id: @user.id
      )
    end

    context 'successfully request' do
      it "returns todo_item" do
        get api_v1_board_todo_item_path(@board, @todo_item), headers: basic_headers, xhr: true

        todo_item = JSON.parse(response.body)

        expect(response).to have_http_status :success
        expect(todo_item.dig('description')).to eq 'Todo item show'
      end

      it "tries to show another user's todo_item" do
        another_user = User.create(
          name: 'another', username: 'another', email: 'ano@ther.com', password: 'teste'
        )

        another_board = another_user.owner_boards.create(name: 'Another Board')

        another_todo = another_board.todo_items.create(
          description: 'Todo item show', user_id: another_user.id
        )

        expect{
          get api_v1_board_todo_item_path(another_board, another_todo),
              headers: basic_headers,
              xhr: true
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end

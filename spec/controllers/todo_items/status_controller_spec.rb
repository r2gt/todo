require "rails_helper"

module TodoItems
  describe StatusController do
    let(:user) do
      User.create(
        name: 'Foo', username: 'Foo', email: 'foo@email.com',
        password: 'foo12345', password_confirmation: 'foo12345', admin:true
      )
    end

    let(:board) do
      user.boards.create(name: 'Board 1')
    end

    let(:todo_item) do
      board.todo_items.create(description: 'Comprar Leite', user_id: user.id)
    end

    it 'changes todo status for done' do
      allow(subject).to receive(:logged_in?).and_return(true)
      allow(subject).to receive(:current_user).and_return(user)

      patch :update, params: { board_id: board.id, todo_item_id: todo_item.id }

      todo_item.reload

      expect(todo_item.done?).to eq true
    end

    it 'changes todo status from done to todo' do
      allow(subject).to receive(:logged_in?).and_return(true)
      allow(subject).to receive(:current_user).and_return(user)

      todo_item.switch!

      expect(todo_item.done?).to eq true

      patch :update, params: { board_id: board.id, todo_item_id: todo_item.id }

      todo_item.reload

      expect(todo_item.todo?).to eq true
    end
  end
end

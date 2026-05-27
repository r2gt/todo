class AddBoardReferenceToTodoItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :todo_items, :board, foreign_key: true
  end
end

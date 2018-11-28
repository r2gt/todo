class AddAasmStateToTodoItems < ActiveRecord::Migration[5.1]
  def change
    add_column :todo_items, :aasm_state, :string
  end
end

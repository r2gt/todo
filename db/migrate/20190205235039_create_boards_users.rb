class CreateBoardsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :boards_users do |t|
      t.references :board, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
    end
  end
end

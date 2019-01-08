require 'rails_helper'

describe 'Todo Items API listing endpoint' do
  describe 'GET /todo_items' do
    before do
      user = User.create(
        name: 'Teste', username: 'teste', email: 'foo@bar.com', password: 'teste'
      )

      @todo_item = user.todo_items.create(description: 'Todo item a ser deletado')
    end

    it "returns todo_items list" do
      get api_v1_todo_items_path, xhr: true

      todo_items = JSON.parse(response.body)

      expect(response).to have_http_status :success
      expect(todo_items.size).to eq 1
      expect(todo_items.first.dig('description')).to eq 'Todo item a ser deletado'
    end
  end
end


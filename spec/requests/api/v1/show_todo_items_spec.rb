require 'rails_helper'

describe 'Todo Items API showing endpoint' do
  describe 'GET /todo_items/:id' do
    before do
      @user = User.create(
        name: 'Teste', username: 'teste', email: 'foo@bar.com', password: 'teste'
      )

      @todo_item = @user.todo_items.create(description: 'Todo item show')
    end

    context 'successfully request' do
      it "returns todo_item" do
        get api_v1_todo_item_path(@todo_item.id), headers: basic_headers, xhr: true

        todo_item = JSON.parse(response.body)

        expect(response).to have_http_status :success
        expect(todo_item.dig('description')).to eq 'Todo item show'
      end
    end
  end
end

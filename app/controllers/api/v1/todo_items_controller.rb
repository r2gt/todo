module Api
  module V1
    class TodoItemsController < API::ApplicationController
      def index
        @todo_items = TodoItem.all

        render json: @todo_items
      end
    end
  end
end

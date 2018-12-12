module Api
  module V1
    class TodoItemsController < API::ApplicationController
      def index
        @todo_items = TodoItem.all

        render json: @todo_items
      end

      def create
        todo_item = TodoItem.new(todo_params.merge({user_id: User.last.id}))

        if todo_item.save
          render json: todo_item, status: :created
        else
          render json: todo_item.errors, status: :unprocessable_entity
        end
      end

      def update
        todo_item = TodoItem.find(params[:id])

        if todo_item.update(todo_params)
          render json: todo_item, status: :ok
        else
          render json: todo_item.errors, status: :unprocessable_entity
        end
      end

      private

      def todo_params
        params.require(:todo_item).permit(:description)
      end
    end
  end
end

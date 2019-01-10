module Api
  module V1
    class TodoItemsController < API::ApplicationController
      before_action :todo_item, except: %i[index create]

      def index
        @todo_items = current_user.todo_items

        render json: @todo_items
      end

      def show
        render json: todo_item, status: :ok
      end

      def create
        @todo_item = current_user.todo_items.new(todo_params)

        if @todo_item.save
          render json: @todo_item, status: :created
        else
          render json: @todo_item.errors, status: :unprocessable_entity
        end
      end

      def update
        if todo_item.update(todo_params)
          render json: todo_item, status: :ok
        else
          render json: todo_item.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if todo_item.destroy
          head :no_content
        end
      end

      private

      def todo_item
        @todo_item ||= current_user.todo_items.find(params[:id])
      end

      def todo_params
        params.require(:todo_item).permit(:description)
      end
    end
  end
end

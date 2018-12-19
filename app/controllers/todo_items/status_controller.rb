module TodoItems
  class StatusController < ApplicationController
    before_action :todo_item

    def update
      todo_item.switch!
    end

    private

    def todo_item
      @todo_item ||= current_user.todo_items.find(params[:todo_item_id])
    end
  end
end

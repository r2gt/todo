class TodoItemsController < ApplicationController
  def index
    @todo_items = TodoItem.all
  end

  def new
    @todo_item = TodoItem.new
  end  

  def create
    @todo_item = TodoItem.new(todo_params)
    
    if @todo_item.save
      redirect_to todo_items_path, notice: 'Todo item was successfully created'
    else
      render :new
    end
  end

  private

  def todo_params
    params.require(:todo_item).permit(:description)
  end
end

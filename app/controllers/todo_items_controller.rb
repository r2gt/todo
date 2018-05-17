class TodoItemsController < ApplicationController
  def index
    @todo_items = TodoItem.all
  end

  def show
    @todo_item = TodoItem.find(params[:id])
  end

  def new
    @todo_item = TodoItem.new
  end

  def edit
    @todo_item = TodoItem.find(params[:id])
  end

  def update
    @todo_item = TodoItem.find(params[:id])

    if @todo_item.update(todo_params)
      redirect_to todo_item_path(@todo_item), notice: "Todo item was successfully updated"
    else
      render :edit
    end
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

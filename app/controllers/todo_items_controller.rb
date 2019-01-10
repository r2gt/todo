class TodoItemsController < ApplicationController
  def index
    @todo_items = current_user.todo_items
  end

  def show
    todo_item
  end

  def new
    @todo_item = TodoItem.new
  end

  def create
    @todo_item = current_user.todo_items.new(todo_params)

    if @todo_item.save
      redirect_to(
        todo_items_path, notice: t('.success')
      )
    else
      render :new
    end
  end

  def edit
    todo_item
  end

  def update
    if todo_item.update(todo_params)
      redirect_to todo_item, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    todo_item.destroy
    redirect_to todo_items_path, notice: t('.success')
  end

  private

  def todo_item
    @todo_item ||= current_user.todo_items.find(params[:id])
  end

  def todo_params
    params.require(:todo_item).permit(:description)
  end
end

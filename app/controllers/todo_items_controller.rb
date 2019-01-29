class TodoItemsController < ApplicationController
  def show
    todo_item
  end

  def new
    @todo_item = board.todo_items.new
  end

  def create
    @todo_item = board.todo_items.new(todo_params)
    @todo_item.user_id = current_user.id

    if @todo_item.save
      redirect_to(
        board_path(@board), notice: t('.success')
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
      redirect_to board_path(@board), notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    todo_item.destroy
    redirect_to board_path(@board), notice: t('.success')
  end

  private

  def todo_item
    @todo_item ||= board.todo_items.find(params[:id])
  end

  def todo_params
    params.require(:todo_item).permit(:description)
  end

  def board
    @board ||= current_user.boards.find(params[:board_id])
  end
end

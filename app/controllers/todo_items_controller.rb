class TodoItemsController < ApplicationController
  def index
    @todo_items = TodoItem.all
  end

  def show
    todo_item
  end

  def new
    @todo_item = TodoItem.new
  end

  def create
    @todo_item = TodoItem.new(todo_params)

    if @todo_item.save
      redirect_to(
        todo_items_path(locale: params[:locale]),
        notice: I18n.t('todo_items.create.notice')
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
      redirect_to(
        todo_item_path(todo_item, locale: params[:locale]),
        notice: I18n.t('todo_items.update.notice')
      )
    else
      render :edit
    end
  end

  def destroy
    todo_item.destroy

    redirect_to(
      todo_items_path(locale: params[:locale]),
      notice: I18n.t('todo_items.destroy.notice')
    )
  end

  private

  def todo_item
    @todo_item ||= TodoItem.find(params[:id])
  end

  def todo_params
    params.require(:todo_item).permit(:description)
  end
end

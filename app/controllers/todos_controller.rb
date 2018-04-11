class TodosController < ApplicationController
  def index
    @todos = TodoItem.all
  end
end

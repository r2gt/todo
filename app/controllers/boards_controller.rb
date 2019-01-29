class BoardsController < ApplicationController
  def index
    @boards = current_user.boards
  end

  def show; board; end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.new(board_params)

    if @board.save
      redirect_to(
        boards_path, notice: t('.success')
      )
    else
      render :new
    end
  end

  def edit; board; end

  def update
    if board.update(board_params)
      redirect_to board, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    board.destroy
    redirect_to boards_path, notice: t('.success')
  end

  private

  def board
    @board ||= current_user.boards.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:name)
  end
end

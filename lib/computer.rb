class Computer

  attr_reader :symbol

  MIDDLE_SQUARE = "4"

  def initialize(symbol)
    @symbol = symbol
  end

  def get_square(board)
    board.state[4] == MIDDLE_SQUARE ? 4 : get_best_move(board)
  end

  def get_best_move(board)
    empty_squares = get_empty_squares(board)

    empty_squares.each do |square|
      square_index = square.to_i

      board.state[square_index] = @symbol
      return square_index if board.game_won?

      board.state[square.to_i] = "O"
      return square_index if board.game_won?

      reset_square(board, square)
    end
    make_random_move(empty_squares)
  end

  private

  def reset_square(board, square)
    board.state[square.to_i] = square
  end

  def make_random_move(empty_squares)
    random_index = rand(empty_squares.count - 1)
    empty_squares[random_index].to_i
  end

  def get_empty_squares(board)
    empty_squares = []

    board.state.each_with_index do |square, index|
      empty_squares << square unless board.occupied?(index)
    end

    empty_squares
  end

end

class Piece
  attr_accessor :position, :color

  def self.on_board?(pos)
    pos.all? { |num| num.between?(0,7) }
  end

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
  end

  def valid_move?(start_pos, end_pos)
    valid = true
    @board.move(start_pos, end_pos)
    if @board.in_check?(color)
      valid = false
    end

    @board.undo_move(start_pos, end_pos)
    valid
  end

end
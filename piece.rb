class Piece
  attr_accessor :position, :color

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
  end

  def on_board?(pos)
    pos.all? { |num| num.between?(0,7) }
  end

end
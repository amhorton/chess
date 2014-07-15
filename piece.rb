class Piece
  attr_accessor :position, :color

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
  end

  def moves
    possible_pos = DELTAS.map { |(x, y)| [x += position.first, y += position.last] }
    possible_pos.select { |(x, y)| x.between?(0, 7) && y.between?(0, 7) }
  end



end
class Piece
  attr_accessor :position, :color, :moved

  def self.on_board?(pos)
    pos.all? { |num| num.between?(0,7) }
  end

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
    @moved = false
  end

end
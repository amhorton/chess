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

class Pawn < Piece

  attr_accessor :moved_two

  def initialize(board, position, color)
    super(board, position, color)
    @deltas = (color == :w) ? [-1, [-1, -1], [1, -1], -2] : [1, [1, 1] , [-1, 1], 2]
    @moved_two = false
  end

  def moves
    moves = []
    if @board[position.first, position.last + @deltas.first].nil?
      moves << [position.first, position.last + @deltas.first]
    end

    if position.last == 1 && color == :b
      moves << [position.first, position.last + @deltas.last]
    end

    if position.last == 6 && color == :w
      moves << [position.first, position.last + @deltas.last]
    end

    if @board[position.first + @deltas[1].first, position.last + @deltas[1].last] &&
       @board[position.first + @deltas[1].first, position.last + @deltas[1].last].color != self.color
      moves << [position.first + @deltas[1].first, position.last + @deltas[1].last]
    end

    if @board[position.first + @deltas[2].first, position.last + @deltas[2].last] &&
       @board[position.first + @deltas[2].first, position.last + @deltas[2].last].color != self.color
      moves << [position.first + @deltas[2].first, position.last + @deltas[2].last]
    end

    moves
  end
end
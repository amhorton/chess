require './piece'

class SteppingPiece < Piece

  def possible_moves
    possible_pos = @deltas.map { |(x, y)| [x += position.first, y += position.last] }
    possible_pos.select { |(x, y)| x.between?(0, 7) && y.between?(0, 7) }
  end

  def moves
    possible_moves.select do |move|
      @board[move[0], move[1]].nil? || @board[move[0], move[1]].color != self.color
    end
  end

end

class Knight < SteppingPiece
  def initialize(board, position, color)
    super(board, position, color)
    @deltas = [
      [-1, -2], [-1, 2],
      [-2, 1], [2, 1],
      [-2, -1], [1, 2],
      [1, -2],[2, -1]
    ]
  end

end

class King < SteppingPiece
  def initialize(board, position, color)
    super(board, position, color)
    @deltas = [
      [0, 1], [1, 0],
      [-1, 0], [0, -1],
      [-1, 1], [1, -1],
      [-1, -1], [1, 1]
    ]
  end
end


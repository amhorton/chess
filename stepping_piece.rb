require './piece'

class SteppingPiece < Piece

  def moves
    possible_pos = DELTAS.map { |(x, y)| [x += position.first, y += position.last] }
    possible_pos.select { |(x, y)| x.between?(0, 7) && y.between?(0, 7) }
  end

  def valid_moves
    moves.select do |move|
      @board[move[0], move[1]].nil? || @board[move[0], move[1]].color != self.color
    end
  end

end

class Knight < SteppingPiece

  DELTAS = [
    [-1, -2],
    [-1, 2],
    [-2, 1],
    [2, 1],
    [-2, -1],
    [1, 2],
    [1, -2],
    [2, -1]
  ]

end

class King < SteppingPiece

  DELTAS = [
    [0, 1],
    [1, 0],
    [-1, 0],
    [0, -1],
    [-1, 1],
    [1, -1],
    [-1, -1],
    [1, 1]
  ]

end

class Pawn < SteppingPiece

end


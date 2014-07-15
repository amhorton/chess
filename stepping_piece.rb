require './piece'

class SteppingPiece < Piece

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


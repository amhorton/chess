require "./piece"

class SlidingPiece < Piece

  def moves
    moves = []

    @deltas.each do |delta|
      i = 1

      while Piece.on_board?([position[0] + (delta[0] * i), position[1] + (delta[1] * i)])
        mult_delta = delta.map { |d| d * i }
        if @board[position[0] + mult_delta[0], position[1] + mult_delta[1]].nil?
          moves << [position[0] + mult_delta[0], position[1] + mult_delta[1]]
        elsif @board[position[0] + mult_delta[0], position[1] + mult_delta[1]].color != self.color
          moves << [position[0] + mult_delta[0], position[1] + mult_delta[1]]
          break
        else
          break
        end

        i += 1
      end
    end

    moves
  end

end


class Bishop < SlidingPiece
  def initialize(board, position, color)
    super(board, position, color)
    @deltas = [[-1, -1], [1, -1], [-1, 1], [1, 1]]
  end
end


class Rook < SlidingPiece
  def initialize(board, position, color)
    super(board, position, color)
    @deltas = [[0,-1], [0,1], [1,0], [-1,0]]
  end
end

class Queen < SlidingPiece
  def initialize(board, position, color)
    super(board, position, color)
    @deltas = [[-1, -1], [1, -1], [-1, 1], [1, 1], [0,-1], [0,1], [1,0], [-1,0]]
  end

end



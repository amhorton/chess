require "./piece"

class SlidingPiece < Piece

  def moves
    moves = []

    DELTAS.each do |delta|
      i = 1

      while [position[0] + (delta[0] * i), position[1] + (delta[1] * i)].on_board?
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

  end

end


class Bishop < SlidingPiece


end



  # DELTAS = [[-1, -1], [1, -1], [-1, 1], [1, 1]]
#
#   opp_arr1 = (-7..7).to_a
#   opp_arr2 = 7.downto(-7).to_a
#   opp_arrs = [opp_arr1, opp_arr2]
#
#   pos_arr = (1..7).to_a
#   neg_arr = (-7..-1).to_a
#   same_arrs = [pos_arr, neg_arr]
#
#   opp_arrs.each do |arr|
#     until arr.size == 1
#       DELTAS << [arr.pop, arr.shift]
#     end
#   end
#
#   same_arrs.each do |arr|
#     arr.each do |num|
#       DELTAS << [num, num]
#     end
#   end

class Rook < SlidingPiece

  DELTAS = []
  (-7..7).each { |num| DELTAS << [0, num] << [num, 0] }

end

class Queen <SlidingPiece

  DELTAS = []

  opp_arr1 = (-7..7).to_a
  opp_arr2 = 7.downto(-7).to_a
  opp_arrs = [opp_arr1, opp_arr2]

  pos_arr = (1..7).to_a
  neg_arr = (-7..-1).to_a
  same_arrs = [pos_arr, neg_arr]

  opp_arrs.each do |arr|
    until arr.size == 1
      DELTAS << [arr.pop, arr.shift]
    end
  end

  same_arrs.each do |arr|
    arr.each do |num|
      DELTAS << [num, num]
    end
  end

  (-7..7).each { |num| DELTAS << [0, num] << [num, 0] }

end



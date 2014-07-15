require "./piece"

class SlidingPiece < Piece



end


class Bishop < SlidingPiece


end



  # DELTAS = []
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



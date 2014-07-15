require "./board"

class Chess

  def initialize
    @board = Board.new
    @turn = :w
  end

  def play

    until over?
      @board.display
      get_user_input

    end

  end

  def get_user_input
    puts (@turn == :w) ? "White to move" : "Black to move"
    print "Enter start and end positions: "
    gets.chomp
  end

end
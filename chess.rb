require "./board"

class Chess

  COL = {
    "a" => 0,
    "b" => 1,
    "c" => 2,
    "d" => 3,
    "e" => 4,
    "f" => 5,
    "g" => 6,
    "h" => 7
  }

  def initialize
    @board = Board.new
    @turn = :w
  end

  def play

    until over?
      begin
        @board.display
        input = get_user_input
        start_pos = input.first
        end_pos = input.last

        unless @board.valid_move?(start_pos, end_pos)
          raise ChessError, "Don't move into check!"
        end
        @board.move(start_pos, end_pos)

      rescue ChessError => e
        puts e.message
        retry
      end

      toggle_turn
      puts "Check" if @board.in_check?(@turn)
    end

    @board.display
    toggle_turn
    puts (@turn == :w) ? "White wins!" : "Black wins!"

  end

  def over?
    @board.checkmate?(@turn)
  end

  def toggle_turn
    @turn = (@turn == :w) ? :b : :w
  end

  def get_user_input
    puts (@turn == :w) ? "White to move" : "Black to move"
    print "Enter start position: "

    start_pos = gets.chomp.split('')
    start_pos[0] = COL[start_pos.first.downcase]
    start_pos[1] = 8 - start_pos.last.to_i

    if @board[start_pos.first, start_pos.last] &&
       @board[start_pos.first, start_pos.last].color != @turn

      raise ChessError, "Don't move your opponent's pieces!"
    end

    print "Enter end position: "

    end_pos = gets.chomp.split('')
    end_pos[0] = COL[end_pos.first.downcase]
    end_pos[1] = 8 - end_pos.last.to_i

    [start_pos, end_pos]
  end

end


Chess.new.play



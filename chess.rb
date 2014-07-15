require "./board"

class Chess

  def initialize
    @board = Board.new
    @turn = :b
  end

  def play

    until over?
      begin
        @board.display
        input = get_user_input
        start_pos = input.first
        end_pos = input.last

        unless @board[start_pos.first, start_pos.last].valid_move?(start_pos, end_pos, @turn)
          raise ChessError "Don't move into check!"
        end

        @board.move(start_pos, end_pos)
      rescue ChessError
        retry
      end

      toggle_turn
    end

  end

  def over?
  end

  def toggle_turn
    @turn = (@turn == :w) ? :b : :w
  end

  def get_user_input
    begin
      puts (@turn == :w) ? "White to move" : "Black to move"
      print "Enter start position: "
      start_pos = gets.chomp.split(',').map(&:to_i)
      raise ChessError "Don't move your opponent's pieces!" if @board[start_pos.first, start_pos.last].color != @turn
      print "Enter end position: "
      end_pos = gets.chomp.split(',').map(&:to_i)
    rescue ChessError
      retry
    end

    [start_pos, end_pos]
  end

end


Chess.new.play



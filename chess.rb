require "./board"
require "colorize"
require "yaml"

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
    puts "Welcome to Chess!"
    puts "Please input moves in the format of a1, b2, etc."
    puts "If you'd like to castle or use en passant, type 'castle' or 'en passant.'"
    puts "At the start of any turn, you can type 'save' to save your game."

    until over?
      begin
        @board.display
        input = get_user_input

        if input == "save"
          save_game
          return
        end

        if input == "castle"
          print "Kingside or queenside? "
          q_or_k = gets.chomp.downcase
          if q_or_k == "kingside"
            raise ChessError, "You can't castle!" unless @board.castling_k?(@turn)
            @board.castle(:k, @turn)
          elsif q_or_k == "queenside"
            raise ChessError, "You can't castle!" unless @board.castling_q?(@turn)
            @board.castle(:q, @turn)
          end

          toggle_turn
          next
        end

        if input == "en passant"

          unless @board.en_passant?(@turn)
            raise ChessError, "You can't en passant right now!"
          end

          new_input = get_user_input

          start_pos = new_input.first
          end_pos = new_input.last

          @board.en_passant(start_pos, end_pos)

          toggle_turn
          next
        end

        start_pos = input.first
        end_pos = input.last

        unless @board.valid_move?(start_pos, end_pos)
          raise ChessError, "Don't move into check!"
        end

        @board.move(start_pos, end_pos)

      rescue ChessError => e
        puts e.message.colorize(:blue)
        retry
      end

      promote

      toggle_turn

      puts "Check!".colorize(:red) if @board.in_check?(@turn)
    end

    @board.display

    if @board.stalemate?(@turn)
      puts "Draw!"
    else
      puts (@turn == :b) ? "White wins!" : "Black wins!"
    end

  end

  private

  def over?
    @board.checkmate?(@turn) || @board.stalemate?(@turn)
  end

  def toggle_turn
    @board.grid.each do |row|
      row.each do |piece|
        if piece && piece.class == Pawn && piece.color != @turn
          piece.moved_two = false
        end
      end
    end

    @turn = (@turn == :w) ? :b : :w
  end

  def get_user_input
    puts (@turn == :w) ? "White to move" : "Black to move"
    print "Enter start position: "

    input = gets.chomp
    return input if input == "save" || input == "castle" || input == "en passant"

    start_pos = input.split('')
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

  def promote
    promotion_hash = {
      "queen" => Queen,
      "knight" => Knight,
      "bishop" => Bishop,
      "rook" => Rook
    }

    @board.grid.each do |row|
      row.each do |piece|
        if piece && piece.class == Pawn && (piece.position.last == 0 || piece.position.last == 7)
          print "Pawn eligible for promotion. Please choose its new rank! "
          new_rank = gets.chomp.downcase
          @board[piece.position.first, piece.position.last] = promotion_hash[new_rank].new(@board, piece.position, piece.color)
        end
      end
    end
  end


  def save_game
    print "Please name your save file. "
    filename = gets.chomp.downcase
    File.write("#{filename}.yml", YAML.dump(self))
  end

end

if __FILE__ == $PROGRAM_NAME
  print "Would you like to start a new game, or load an old game? "
  response = gets.chomp.downcase
  if response == "new game"
    Chess.new.play
  elsif response == "load game"
    print "What's the name of your save file? "
    filename = gets.chomp.downcase
    YAML.load_file("#{filename}.yml").play
  end
end






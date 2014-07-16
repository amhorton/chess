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

    until over?
      begin
        @board.display
        input = get_user_input

        if input == "save"
          save_game
          return
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

      toggle_turn
      puts "Check!".colorize(:red) if @board.in_check?(@turn)
    end

    @board.display
    toggle_turn
    puts (@turn == :w) ? "White wins!" : "Black wins!"

  end

  private

  def over?
    @board.checkmate?(@turn)
  end

  def toggle_turn
    @turn = (@turn == :w) ? :b : :w
  end

  def get_user_input
    puts (@turn == :w) ? "White to move" : "Black to move"
    print "Enter start position, or \"save\" to save the game: "

    input = gets.chomp
    return input if input == "save"

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






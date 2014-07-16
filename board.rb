require './stepping_piece'
require './sliding_piece'
require "colorize"

class ChessError < StandardError
end

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate_grid
    @taken_pieces = []
  end

  def [](x, y)
    @grid[y][x]
  end

  def []=(x, y, piece)
    @grid[y][x] = piece
  end

  def move(start_pos, end_pos)
    raise ChessError, "No piece there!" unless self[start_pos.first, start_pos.last]
    unless self[start_pos.first, start_pos.last].moves.include?(end_pos)
      raise ChessError, "That piece can't move there!"
    end

    @taken_pieces << self[end_pos.first, end_pos.last]

    self[end_pos.first, end_pos.last] = self[start_pos.first, start_pos.last]
    self[start_pos.first, start_pos.last] = nil
    self[end_pos.first, end_pos.last].position = end_pos
  end

  def checkmate?(color)
    if in_check?(color)
      @grid.each do |row|
        row.each do |piece|

          if piece && piece.color == color
            return false if piece.moves.any? { |move| valid_move?(piece.position, move)}
          end
        end
      end

      return true
    end

    false
  end

  def valid_move?(start_pos, end_pos)
    valid = true
    move(start_pos, end_pos)
    if in_check?(self[end_pos.first, end_pos.last].color)
      valid = false
    end

    undo_move(start_pos, end_pos)
    valid
  end

  def in_check?(color)
    king_pos = []

    @grid.each_with_index do |row, index1|
      row.each_with_index do |piece, index2|
        king_pos += [index2, index1] if piece.class == King && piece.color == color
      end
    end

    @grid.each_with_index do |row, index1|
      row.each_with_index do |piece, index2|
        return true if piece && piece.color != color && piece.moves.include?(king_pos)
      end
    end

    false
  end

  def display
    puts render
  end

  private

  def undo_move(start_pos, end_pos)
    self[end_pos.first, end_pos.last].position = start_pos
    self[start_pos.first, start_pos.last] = self[end_pos.first, end_pos.last]
    self[end_pos.first, end_pos.last] = @taken_pieces.pop
  end

  def populate_grid
    #black pieces
    self[0, 0] = Rook.new(self, [0, 0], :b)
    self[1, 0] = Knight.new(self, [1, 0], :b)
    self[2, 0] = Bishop.new(self, [2, 0], :b)
    self[3, 0] = Queen.new(self, [3, 0], :b)
    self[4, 0] = King.new(self, [4, 0], :b)
    self[5, 0] = Bishop.new(self, [5, 0], :b)
    self[6, 0] = Knight.new(self, [6, 0], :b)
    self[7, 0] = Rook.new(self, [7, 0], :b)

    (0..7).each do |num|
      self[num, 1] = Pawn.new(self, [num, 1], :b)
    end

    #white pieces
    self[0, 7] = Rook.new(self, [0, 7], :w)
    self[1, 7] = Knight.new(self, [1, 7], :w)
    self[2, 7] = Bishop.new(self, [2, 7], :w)
    self[3, 7] = Queen.new(self, [3, 7], :w)
    self[4, 7] = King.new(self, [4, 7], :w)
    self[5, 7] = Bishop.new(self, [5, 7], :w)
    self[6, 7] = Knight.new(self, [6, 7], :w)
    self[7, 7] = Rook.new(self, [7, 7], :w)

    (0..7).each do |num|
      self[num, 6] = Pawn.new(self, [num, 6], :w)
    end

  end

  def render
    color_toggle = true
    rendered = "\n   A  B  C  D  E  F  G  H\n"

    @grid.each_with_index do |row, index1|
      rendered += (8 - index1).to_s + " "

      row.each_with_index do |piece, index2|
        color = color_toggle ? :grey : :white

        unless piece.nil?
          if piece.color == :b
            rendered += " ♛ ".colorize(:background => color) if piece.class == Queen
            rendered += " ♚ ".colorize(:background => color) if piece.class == King
            rendered += " ♞ ".colorize(:background => color) if piece.class == Knight
            rendered += " ♝ ".colorize(:background => color) if piece.class == Bishop
            rendered += " ♜ ".colorize(:background => color) if piece.class == Rook
            rendered += " ♟ ".colorize(:background => color) if piece.class == Pawn
          else
            rendered += " ♕ ".colorize(:background => color) if piece.class == Queen
            rendered += " ♔ ".colorize(:background => color) if piece.class == King
            rendered += " ♘ ".colorize(:background => color) if piece.class == Knight
            rendered += " ♗ ".colorize(:background => color) if piece.class == Bishop
            rendered += " ♖ ".colorize(:background => color) if piece.class == Rook
            rendered += " ♙ ".colorize(:background => color) if piece.class == Pawn
          end
        else
          rendered += "   ".colorize(:background => color)
        end

        color_toggle = !color_toggle
      end

      color_toggle = !color_toggle
      rendered += "\n"
    end

    rendered += "\n"
  end

end






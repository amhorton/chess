require './stepping_piece'
require './sliding_piece'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate_grid
  end

  def [](x,y)
    @grid[y][x]
  end

  def []=(x,y, piece)
    @grid[y][x] = piece
  end

  def move(start_pos, end_pos)
  end

  def check(color)
  end

  def render
  end

  private

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

end

our_board = Board.new

francis = Bishop.new(our_board, [4,4], :w)

p francis.moves
p our_board
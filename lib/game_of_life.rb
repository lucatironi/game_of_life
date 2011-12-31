require 'rubygems'
require 'gosu'
require 'chingu'

require 'cell'
require 'board'

include Gosu
include Chingu

class GameOfLife < Chingu::Window
  WINDOW_SIZE = 400
  CELL_SIZE = WINDOW_SIZE / 5
  @@tick = 0

  attr_reader :board

  def initialize
    super(WINDOW_SIZE, WINDOW_SIZE, false, 200)
    $window.caption = "Game of Life - Generation #{@@tick}"
    self.input = { :esc => :exit, :space => :toggle_running }
    @running = false
    @board = Board.new
  end

  def running?
    @running
  end

  def seed cells = []
    @board = Board.new cells
  end

  def update
    super
    if @running
      @board = @board.tick!
      $window.caption = "Game of Life - Generation #{@@tick}"
      @@tick += 1
    end
  end

  def draw
    fill(Color::WHITE)
    for cell in @board.cells.select &:alive?
      $window.fill_rect([cell.coords[:x] * CELL_SIZE, cell.coords[:y] * CELL_SIZE, CELL_SIZE, CELL_SIZE], 0xff000000, 0)
    end
  end

  def toggle_running
    @running = !@running
  end
end
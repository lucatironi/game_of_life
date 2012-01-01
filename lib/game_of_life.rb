require 'rubygems'
require 'gosu'
require 'chingu'

require 'cell'
require 'board'

include Gosu
include Chingu

class GameOfLife < Chingu::Window
  WINDOW_WIDTH = 400
  WINDOW_HEIGHT = 400
  CELL_SIZE = 20
  @@tick = 0

  attr_reader :board

  def initialize
    super(WINDOW_WIDTH, WINDOW_HEIGHT, false, 100)
    $window.caption = "Game of Life - Generation #{@@tick}"
    self.input = { :esc => :exit, :space => :toggle_running, :return => :random_seed }
    @running = false
    @board = Board.new
  end

  def running?
    @running
  end

  def seed cells = []
    @board = Board.new cells
  end

  def random_seed
    new_seed = []
    for j in 0..(WINDOW_HEIGHT / CELL_SIZE)-1
      for i in 0..(WINDOW_WIDTH / CELL_SIZE)-1
        status = rand(6) == 1
        new_seed << (status ? LiveCell.new(i, j) : DeadCell.new(i, j))
      end
    end
    self.seed new_seed
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
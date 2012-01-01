require 'spec_helper'

describe GameOfLife do
  before :each do
    @game = GameOfLife.new
  end

  after :each do
    @game.close
  end

  specify { @game.should be_kind_of GameOfLife }
  specify { @game.should_not be_running }

  context ".board" do
    specify { @game.board.should be_kind_of Board }
  end

  context ".toggle_running" do
    it "should change the running state of the game" do
      @game.should_not be_running
      @game.toggle_running
      @game.should be_running
      @game.toggle_running
      @game.should_not be_running
    end
  end

  context ".random_seed" do
    it "should populate the Board with an initial random seed of Cells" do
      @game.random_seed
      @game.board.cells.size.should eq((GameOfLife::WINDOW_WIDTH / GameOfLife::CELL_SIZE) * (GameOfLife::WINDOW_HEIGHT / GameOfLife::CELL_SIZE))
    end
  end

  context ".update" do
    before(:each) { @game.toggle_running }

    it "should update the board when running" do
      @game.seed([LiveCell.new])
      @game.update
      @game.board.cells.first.should_not be_alive
    end

    it "should create an oscillator with seed [0,1,0,0,1,0,0,1,0]" do
        @game.seed([DeadCell.new(0,0), LiveCell.new(1,0), DeadCell.new(2,0),
                    DeadCell.new(0,1), LiveCell.new(1,1), DeadCell.new(2,1),
                    DeadCell.new(0,2), LiveCell.new(1,2), DeadCell.new(2,2)])
        @game.update
        @game.board.cell_at({:x => 1, :y => 0}).should_not be_alive
        @game.board.cell_at({:x => 1, :y => 2}).should_not be_alive
        @game.board.cell_at({:x => 0, :y => 1}).should be_alive
        @game.board.cell_at({:x => 2, :y => 1}).should be_alive
    end
  end
end
require 'spec_helper'

describe Board do
  specify { Board.new.should be_kind_of Board }
  context ".cells" do
    it "should have a set of Cells" do
      Board.new.cells.should be_kind_of Array
    end

    it "should accepts an initial seed of Cells" do
      Board.new([LiveCell.new]).cells.first.should be_kind_of Cell
    end

    it "should return the initial seed of Cells" do
      cell = LiveCell.new
      Board.new([cell]).cells.first.should eq(cell)
    end
  end

  context ".tick!" do
    specify { Board.new.tick!.should be_kind_of Board }

    it "should evolve its Cells" do
      Board.new([LiveCell.new]).tick!.cells.first.should_not be_alive
    end
  end

  context ".alive_neighbours" do
    it "should return 2 alive neighbours for the Central cell with seed [0,1,0,0,1,0,0,1,0]" do
      Board.new([DeadCell.new(0,0), LiveCell.new(1,0), DeadCell.new(2,0),
                 DeadCell.new(0,1), LiveCell.new(1,1), DeadCell.new(2,1),
                 DeadCell.new(0,2), LiveCell.new(1,2), DeadCell.new(2,2)]).alive_neighbours({x: 1, y: 1}).should eq(2)
    end

    it "should return 3 alive neighbours for the Central cell with seed [0,1,0,0,1,0,1,1,0]" do
       Board.new([DeadCell.new(0,0), LiveCell.new(1,0), DeadCell.new(2,0),
                  DeadCell.new(0,1), LiveCell.new(1,1), DeadCell.new(2,1),
                  LiveCell.new(0,2), LiveCell.new(1,2), DeadCell.new(2,2)]).alive_neighbours({x: 1, y: 1}).should eq(3)
    end

    it "should return 1 alive neighbours for the NorthWest cell with seed [1,1,0,0,0,0,1,1,1]" do
      Board.new([LiveCell.new(0,0), LiveCell.new(1,0), DeadCell.new(2,0),
                 DeadCell.new(0,1), DeadCell.new(1,1), DeadCell.new(2,1),
                 LiveCell.new(0,2), LiveCell.new(1,2), LiveCell.new(2,2)]).alive_neighbours({x: 0, y: 0}).should eq(1)
    end
  end
end
require 'spec_helper'

describe Cell do

  context ".coords" do
    specify { Cell.new(0,0).coords.should eq({ x: 0, y: 0 }) }
    specify { Cell.new(0,1).coords.should eq({ x: 0, y: 1 }) }
    context "[:x]" do
      specify { Cell.new(0,1).coords[:x].should eq(0) }
    end
    context "[:y]" do
      specify { Cell.new(0,1).coords[:y].should eq(1) }
    end
  end

  context "LiveCell" do
    let(:cell) { LiveCell.new }

    specify { cell.should be_kind_of Cell }
    specify { LiveCell.new.should be_alive }

    context ".evolve!" do
      specify { cell.evolve!.should_not be_alive }

      it "should die with less than 2 neighbours" do
        cell.evolve!(1).should_not be_alive
      end
      it "should live to the next genearation with 2 neighbours" do
        cell.evolve!(2).should be_alive
      end
      it "should live to the next genearation with 3 neighbours" do
        cell.evolve!(3).should be_alive
      end
      it "should die with more than 3 neighbours" do
        cell.evolve!(4).should_not be_alive
      end
    end
  end

  context "DeadCell" do
    let(:cell) { DeadCell.new }

    specify { cell.should be_kind_of Cell }
    specify { DeadCell.new.should_not be_alive }

    context ".evolve!" do
      specify { cell.evolve!.should_not be_alive }

      it "should remain dead with less than 3 neighbours" do
        cell.evolve!(2).should_not be_alive
      end
      it "should come alive with exactly 3 neighbours" do
        cell.evolve!(3).should be_alive
      end
      it "should remain dead with more than 3 neighbours" do
        cell.evolve!(4).should_not be_alive
      end
    end
  end
end
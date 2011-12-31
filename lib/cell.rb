class Cell
  def initialize x = 0, y = 0
    @x = x
    @y = y
  end

  def coords
    { :x => @x, :y => @y }
  end
end

class LiveCell < Cell
  def alive?
    true
  end

  def evolve! neighbours = 0
    return DeadCell.new(self.coords[:x], self.coords[:y]) if neighbours < 2 or neighbours > 3
    LiveCell.new(self.coords[:x], self.coords[:y])
  end
end

class DeadCell < Cell
  def alive?
    false
  end

  def evolve! neighbours = 0
    return LiveCell.new(self.coords[:x], self.coords[:y]) if neighbours == 3
    DeadCell.new(self.coords[:x], self.coords[:y])
  end
end
class Board
  attr_accessor :cells

  def initialize seed = []
    @cells = seed
  end

  def cell_at coords
    @cells.select { |cell| cell.coords == { :x => coords[:x], :y => coords[:y] } }.first
  end

  def alive_neighbours coords
    @cells.count { |cell| cell.alive? and
                         (cell.coords == { :x => coords[:x],   :y => coords[:y]-1 } or #N
                          cell.coords == { :x => coords[:x]+1, :y => coords[:y]-1 } or #NE
                          cell.coords == { :x => coords[:x]+1, :y => coords[:y]   } or #E
                          cell.coords == { :x => coords[:x]+1, :y => coords[:y]+1 } or #SE
                          cell.coords == { :x => coords[:x],   :y => coords[:y]+1 } or #S
                          cell.coords == { :x => coords[:x]-1, :y => coords[:y]+1 } or #SW
                          cell.coords == { :x => coords[:x]-1, :y => coords[:y]   } or #W
                          cell.coords == { :x => coords[:x]-1, :y => coords[:y]-1 })   #NW
                  }
  end

  def tick!
    new_board = Board.new
    for cell in self.cells
      new_board.cells << cell.evolve!(self.alive_neighbours(cell.coords))
    end
    return new_board
  end
end
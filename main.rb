#!/usr/bin/env ruby
$LOAD_PATH << './lib'

require 'game_of_life'

game = GameOfLife.new
game.seed([DeadCell.new(0,0), DeadCell.new(1,0), DeadCell.new(2,0), DeadCell.new(3,0), DeadCell.new(4,0),
           DeadCell.new(0,1), DeadCell.new(1,1), LiveCell.new(2,1), DeadCell.new(3,1), DeadCell.new(4,1),
           DeadCell.new(0,2), DeadCell.new(1,2), LiveCell.new(2,2), DeadCell.new(3,2), DeadCell.new(4,2),
           DeadCell.new(0,3), DeadCell.new(1,3), LiveCell.new(2,3), DeadCell.new(3,3), DeadCell.new(4,3),
           DeadCell.new(0,4), DeadCell.new(1,4), DeadCell.new(2,4), DeadCell.new(3,4), DeadCell.new(4,4)])
game.show
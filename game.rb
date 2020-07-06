require_relative "board"
require_relative "player"

require_relative "board"
require_relative "player"


class Game

  attr_accessor :board

  def initialize
    @board = Board.new
    instructions
    @player1 = Player.new(1)
    @player2 = Player.new(2)
  end

  def instructions
    puts <<-RULES

            Welcome to Tic-Tac-Toe: Command Line Edition!

            The rules are simple:

            Players will alternate placing a marker on the board.
            The first person to have 3 of their markers in a row,
            in a column, or diagonally, will win the game!

            If neither player has 3 consecutive markers, the result
            is a Cat's Game, or a tie!

    RULES
  end
end

g = Game.new


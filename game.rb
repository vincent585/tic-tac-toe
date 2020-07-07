require_relative "board"
require_relative "player"

class Game

  attr_reader :board, :players
  attr_accessor :current_player_index

  def initialize
    @board = Board.new
    instructions
    @players = [Player.new(1), Player.new(2)]
    @current_player_index = 0
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

  def play_game
    turn_count = 0 
    board.display_board
    until turn_count == 9 do
      make_move
      board.display_board
      update_current_turn
      turn_count += 1
    end
    #check to see if win conditions are met
      #if yes, declare winner and exit game loop
      #if no, display updated board and repeat loop
  end

  private

  def make_move
    puts "Player #{players[current_player_index].player_number}! Choose a cell (1-9) where you would like to place your marker."
    update_board(valid_move) 
  end


  def update_current_turn
    @current_player_index = (@current_player_index + 1) % players.size
  end

  def valid_move
    move = gets.chomp
    until move.match?(/^[1-9]{1}$/) && cell_empty?(move) do 
      print "Please enter a valid cell: "
      move = gets.chomp
    end
    move
  end
  
  def update_board(move)
    index = move.to_i - 1
    board.game_board[index] = players[current_player_index].marker
  end

  def cell_empty?(cell)
    index = cell.to_i - 1
    return false if board.game_board[index] == players[0].marker ||
                    board.game_board[index] == players[1].marker
    true
  end
end

g = Game.new
g.play_game



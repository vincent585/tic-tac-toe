require_relative "board"
require_relative "player"

class Game

  attr_reader :board, :players
  attr_accessor :current_player_index

  WIN_CONDITIONS = [
    [0, 1, 2], [3, 4, 5],
    [6, 7, 8], [0, 3, 6],
    [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ]

  def initialize
    @board = Board.new
    instructions
    @players = [Player.new(1), Player.new(2)]
    @current_player_index = 0
  end

  def play_game
    turn_count = 0 
    board.display_board
    until turn_count == 9 do
      make_move
      board.display_board
      if player_won?(current_player_index)
        puts "Player #{players[current_player_index].player_number} wins!".center(65)
        puts
        break
      end
      update_current_turn
      turn_count += 1
    end
  end

  private

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

  def player_won?(last_move)
    WIN_CONDITIONS.any? do |outcome|
      outcome.all? { |cell| board.game_board[cell] == players[last_move].marker }
    end
  end
end

g = Game.new
g.play_game



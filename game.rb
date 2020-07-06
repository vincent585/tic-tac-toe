require_relative "board"
require_relative "player"

class Game

  attr_reader :board, :current_turn, :players

  def initialize
    @board = Board.new
    instructions
    @players = [Player.new(1), Player.new(2)]
    @current_turn = players.sample
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
    board.display_board
    make_move
    #call the place_marker method from the current player turn
      #e = players.cycle, e.next e.peek
    #update the board with that player's marker
    #check to see if win conditions are met
      #if yes, decalre winner and exit game loop
      #if no, display updated board and repeat loop
  end

  def make_move
    puts "Choose a cell (1-9) where you would like to place your marker."
    chosen_cell = gets.chomp
    validate_move(chosen_cell)
    index = chosen_cell.to_i - 1
    board.game_board[index] = current_turn.marker
    board.display_board
  end

  def update_current_turn
    current_turn.next
    current_turn.peek
  end

  

  private

  def validate_move(move)
    loop do
      if move.match?(/\d/)
        break
      else
        print "Please enter a valid cell: "
      end
    end
    move
  end

  
  
  # def update_board(move)

  # end

end



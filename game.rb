class Board

  attr_reader :game_board
  
  def initialize
    @game_board = create_board
  end

  def display_board
    puts
    puts <<~HEREDOC
     #{game_board[0]} | #{game_board[1]} | #{game_board[2]}
    ---+---+---
     #{game_board[3]} | #{game_board[4]} | #{game_board[5]}
    ---+---+---
     #{game_board[6]} | #{game_board[7]} | #{game_board[8]}
    HEREDOC
    puts
  end

  private

  def create_board
    Array.new(9) { |cell| (cell + 1). to_s }
  end
end

b = Board.new
b.display_board
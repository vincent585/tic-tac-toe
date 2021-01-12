class Board
  attr_accessor :game_board

  def initialize
    @game_board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def display_board
    puts <<-HEREDOC

                            #{game_board[0]} | #{game_board[1]} | #{game_board[2]}
                           ---+---+---
                            #{game_board[3]} | #{game_board[4]} | #{game_board[5]}
                           ---+---+---
                            #{game_board[6]} | #{game_board[7]} | #{game_board[8]}

    HEREDOC
  end
end

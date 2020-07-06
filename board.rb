class Board

  attr_accessor :game_board
  
  def initialize
    @game_board = create_board
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

  private

  def create_board
    Array.new(9) { |cell| (cell + 1).to_s }
  end
end
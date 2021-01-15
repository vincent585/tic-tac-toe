# frozen_string_literal: true

require './lib/game'
require './lib/board'
require './lib/player'

describe Game do
  describe '#player_won?' do
    context 'when the board is new' do
      subject(:new_game) { described_class.new }
      it 'does not end the game' do
        expect(new_game).not_to be_player_won
      end
    end

    context 'when the top row reads X X X' do
      subject(:top_row_win) { described_class.new }
      before do
        p1 = top_row_win.players[0]
        p2 = top_row_win.players[1]
        p1.instance_variable_set(:@marker, 'X')
        p2.instance_variable_set(:@marker, 'O')
        top_row_win.board.instance_variable_set(:@game_board, ['X', 'X', 'X', 4, 5, 6, 7, 8, 9])
      end

      it 'ends the game' do
        expect(top_row_win).to be_player_won
      end
    end

    context 'when the middle column reads O O O' do
      subject(:middle_column_win) { described_class.new }
      before do
        p1 = middle_column_win.players[0]
        p2 = middle_column_win.players[1]
        p1.instance_variable_set(:@marker, 'X')
        p2.instance_variable_set(:@marker, 'O')
        middle_column_win.board.instance_variable_set(:@game_board, [1, 'O', 3, 4, 'O', 6, 7, 'O', 9])
      end

      it 'ends the game' do
        expect(middle_column_win).to be_player_won
      end
    end

    context 'when the diagonal reads X X X' do
      subject(:diagonal_win) { described_class.new }
      before do
        diagonal_win.players[0].instance_variable_set(:@marker, 'X')
        diagonal_win.players[1].instance_variable_set(:@marker, 'O')
        diagonal_win.board.instance_variable_set(:@game_board, ['X', 2, 3, 4, 'X', 6, 7, 8, 'X'])
      end

      it 'ends the game' do
        expect(diagonal_win).to be_player_won
      end
    end
  end

  describe 'turn_limit_reached?' do
    context 'when the game is new' do
      subject(:new_game) { described_class.new }

      it 'does not end the game' do
        expect(new_game).not_to be_turn_limit_reached
      end
    end

    context 'when the turn count is 5' do
      subject(:turn_count_five) { described_class.new }

      it 'does not end the game' do
        turn_count_five.instance_variable_set(:@turn_count, 5)
        expect(turn_count_five).not_to be_turn_limit_reached
      end
    end

    context 'when the turn count reaches the turn limit' do
      subject(:turn_limit) { described_class.new }

      it 'ends the game' do
        turn_limit.instance_variable_set(:@turn_count, 9)
        expect(turn_limit).to be_turn_limit_reached
      end
    end
  end
end

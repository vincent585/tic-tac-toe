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

  describe '#turn_limit_reached?' do
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

  describe '#make_move' do
    context 'when a player enters a valid move' do
      subject(:game) { described_class.new }

      before do
        game.players[0].instance_variable_set(:@marker, 'X')
        valid_input = '3'
        allow(game).to receive(:puts)
        allow(game).to receive(:select_cell).and_return(valid_input)
      end

      it 'updates the board' do
        game.make_move
        expect(game.board.game_board).to eq([1, 2, 'X', 4, 5, 6, 7, 8, 9])
      end
    end

    context 'when a player enters an invalid move, then a valid move' do
      subject(:invalid_game) { described_class.new }

      before do
        invalid_game.players[0].instance_variable_set(:@marker, 'X')
        invalid_cell = '12'
        valid_cell = '1'
        allow(invalid_game).to receive(:puts)
        allow(invalid_game).to receive(:select_cell).and_return(invalid_cell, valid_cell)
      end

      it 'displays error message once and ends the loop' do
        expect(invalid_game).to receive(:puts).with('Please enter a valid cell!').once
        invalid_game.make_move
      end

      it 'updates the board' do
        invalid_game.make_move
        expect(invalid_game.board.game_board).to eq(['X', 2, 3, 4, 5, 6, 7, 8, 9])
      end
    end

    context 'when a player selects a filled cell, then a valid cell' do
      subject(:filled_cell_game) { described_class.new }

      before do
        filled_cell_game.players[0].instance_variable_set(:@marker, 'X')
        filled_cell_game.players[1].instance_variable_set(:@marker, 'O')
        filled_cell_game.board.instance_variable_set(:@game_board, [1, 'O', 3, 4, 5, 6, 7, 8, 9])
        filled_cell = '2'
        valid_cell = '4'
        allow(filled_cell_game).to receive(:puts)
        allow(filled_cell_game).to receive(:select_cell).and_return(filled_cell, valid_cell)
      end

      it 'displays an error message then ends the loop' do
        expect(filled_cell_game).to receive(:puts).with('Please enter a valid cell!').once
        filled_cell_game.make_move
      end

      it 'updates the valid cell and does not change the prefilled cell' do
        filled_cell_game.make_move
        expect(filled_cell_game.board.game_board).to eq([1, 'O', 3, 'X', 5, 6, 7, 8, 9])
      end
    end
  end

  describe '#update_current_turn' do
    subject(:current_turn_zero) { described_class.new }
    context 'when the current player index is 0' do
      it 'updates the current player index to 1' do
        current_turn_zero.update_current_turn
        expect(current_turn_zero.current_player_index).to eq(1)
      end
    end

    context 'when current player index is 1' do
      subject(:current_turn_one) { described_class.new }
      it 'updates the current player index to 0' do
        current_turn_one.instance_variable_set(:@current_player_index, 1)
        current_turn_one.update_current_turn
        expect(current_turn_one.current_player_index).to eq(0)
      end
    end
  end

  describe '#increment_turn_count' do
    context 'when the game is new' do
      subject(:new_count) { described_class.new }
      it 'increments the turn count to 1' do
        new_count.increment_turn_count
        expect(new_count.turn_count).to eq(1)
      end
    end

    context 'when the turn count is 5' do
      subject(:five_count) { described_class.new }
      it 'increments the turn count to 6' do
        five_count.instance_variable_set(:@turn_count, 5)
        five_count.increment_turn_count
        expect(five_count.turn_count).to eq(6)
      end
    end
  end
end

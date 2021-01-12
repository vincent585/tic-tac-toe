# frozen_string_literal: true

require './lib/game'
require './lib/board'
require './lib/player'

describe Game do
  describe '#player_won?' do
    context 'when the board is new' do
      subject(:new_game) { described_class.new }
      it 'does not end the game' do
        expect(:new_game).not_to be_player_won
      end
    end
  end
end

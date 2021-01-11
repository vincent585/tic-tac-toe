# frozen_string_literal: true

require './lib/player'

describe Player do
  subject(:player_one) { described_class.new(1) }
  describe '#set_marker' do
    context 'when user inputs a valid marker' do
      it 'stops the loop and does not display an error message' do
        valid_input = 'x'
        allow(player_one).to receive(:player_input).and_return(valid_input)
        expect(player_one).not_to receive(:puts).with('Please enter a single letter, a-z!')
        player_one.set_marker
      end

      it 'sets the marker value to X' do
        valid_input = 'x'
        allow(player_one).to receive(:puts)
        allow(player_one).to receive(:player_input).and_return(valid_input)
        player_one.set_marker
        expect(player_one.marker).to eq('X')
      end
    end

    context 'when user inputs an invalid marker, then a valid marker' do
      before do
        num = '9'
        valid_input = 'x'
        allow(player_one).to receive(:puts)
        allow(player_one).to receive(:player_input).and_return(num, valid_input)
      end

      it 'completes loop and displays error message once' do
        expect(player_one).to receive(:puts).with('Please enter a single letter, a-z!').once
        player_one.set_marker
      end

      it 'sets the value of marker to X' do
        player_one.set_marker
        expect(player_one.marker).to eq('X')
      end
    end
  end
end

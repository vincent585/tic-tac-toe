class Player
  attr_reader :marker, :player_number

  def initialize(number)
    @player_number = number
    @marker = set_marker
  end

  private

  def set_marker
    print "Player #{player_number}! Please choose a letter to indicate your marker: "
    chosen_marker = gets.chomp
    validate_marker(chosen_marker)
  end

  def validate_marker(chosen_marker)
    until chosen_marker.match?(/[a-zA-Z]/)
      print 'Please enter a letter: '
      chosen_marker = gets.chomp
    end
    chosen_marker.upcase
  end
end

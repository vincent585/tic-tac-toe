class Player
  attr_reader :marker, :player_number

  def initialize(number)
    @player_number = number
    @marker = set_marker
  end

  def set_marker
    print "Player #{player_number}! Please choose a letter to indicate your marker: "
    loop do
      @marker = validate_marker(player_input)
      break if @marker

      puts 'Please enter a single letter, a-z!'
    end
  end

  private

  def validate_marker(chosen_marker)
    return chosen_marker.upcase if chosen_marker.match?(/[a-zA-Z]/)
  end

  def player_input
    gets.chomp
  end
end

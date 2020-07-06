class Player

  attr_reader :marker, :player_number

  def initialize(number)
    @player_number = number
    @marker = set_marker
  end

  
  private

  def set_marker
    puts "Player #{player_number}! Please choose a letter to indicate your marker."
    chosen_marker = ""
    loop do
      chosen_marker = gets.chomp
      if chosen_marker.match?(/[a-zA-Z]/)
        break
      else
        puts "Please enter a letter."
      end
    end
    chosen_marker.upcase
  end
end


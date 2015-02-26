class HumanPlayer
  attr_reader :secret_word
  attr_accessor :guessed

  def initialize
    @guessed = []
  end

  def pick_secret_word
    puts "Pick a word."
    puts "How many characters is it?"
    loop do
      @word_length = gets.chomp
      return @word_length.to_i if @word_length.to_i > 0
      puts "Invalid input, how many character is the word?"
    end
  end

  def check_guess(guess)
    locations = []
    puts "#{guess} was guessed, what are its positions (1 - #{@word_length})?"
    loop do
      guess = gets.chomp.split(",")
      if guess.all? { |pos| pos.to_i > 0 }
        return guess.map{ |pos| pos.to_i - 1 }
      end
      puts "Invalid input, what are its positions?"
    end
  end

  def receive_secret_length(word_length)
    puts "The secret word is #{word_length}-letters long."
  end

  def guess
    puts "What is your guess?"
    loop do
      guess = gets.chomp.downcase
      unless guess =~ /[a-z]/ && guess.length == 1
        puts "Invalid guess, pick a letter."
        next
      end
      if @guessed.include?(guess)
        puts "Letter already guessed. pick again."
        next
      end
      @guessed << guess
      return guess
    end
  end

  def reveal_word
    puts "Game over, what was the word?"
    gets.chomp
  end

  def get_locations(locations)
    if locations.empty?
      puts "Wrong guess."
    else
      locations = locations.map { |loc| loc + 1 }
      puts "Guess found at locations: #{locations.join(", ")}."
    end
  end
end

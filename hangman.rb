class Hangman
  def initialize(chooser, guesser)
    @chooser = chooser
    @guesser = guesser
  end

  def game
    @guesses_remaining = 8
    word_length = @chooser.pick_secret_word
    @board = "_" * word_length
    @guesser.receive_secret_length(word_length)
    until game_over?
      puts "You have #{@guesses_remaining} guesses left."
      display
      guess = @guesser.guess
      locations = @chooser.check_guess(guess)
      @guesses_remaining -= 1 if locations.empty?
      locations.each do |loc|
        @board[loc] = guess
      end
    end

    display
  end

  def game_over?
    if @guesses_remaining == 0
      puts "Guesser loses :-("
      true
    elsif !@board.include?("_")
      puts "Guesser wins!"
      true
    else
      false
    end
  end

  def display
    puts @board
    @guesser.guessed.each do |guess|
      print guess unless @board.include?(guess)
    end
    puts ""
  end

end



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
    puts "The chooser picked a #{word_length}-letter word."
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

  def handle_guess_response

  end

end


class ComputerPlayer
  attr_reader :secret_word
  attr_accessor :guessed

  def initialize(dictionary_file)
    @dictionary = File.readlines(dictionary_file).map(&:chomp)
    @guessed = []
  end

  def pick_secret_word
    @secret_word = @dictionary.sample
    @secret_word.length
  end

  def check_guess(guess)
    locations = []
    @secret_word.split("").each_with_index do |char, idx|
      locations << idx if char == guess
    end

    locations
  end

  def receive_secret_length(word_length)

  end

  def guess
    loop do
      guess = ("a".."z").to_a.sample
      unless @guessed.include?(guess)
        @guessed << guess
        return guess
      end
    end
  end

  def handle_guess_response

  end
end

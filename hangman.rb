require_relative 'computer_player.rb'
require_relative 'human_player.rb'

class Hangman
  def initialize(chooser, guesser)
    @chooser = chooser
    @guesser = guesser
  end

  def game
    @guesser.guessed = []
    @guesses_remaining = 8
    word_length = @chooser.pick_secret_word
    @board = "_" * word_length
    @guesser.receive_secret_length(word_length)
    until game_over?
      play_turn
    end
  end

  def play_turn
    puts "You have #{@guesses_remaining} guesses left."
    display
    guess = @guesser.guess
    locations = @chooser.check_guess(guess)
    @guesses_remaining -= 1 if locations.empty?
    locations.each do |loc|
      @board[loc] = guess
    end
    @guesser.get_locations(locations)
  end

  def game_over?
    if @guesses_remaining == 0
      secret_word = @chooser.reveal_word
      puts "#{secret_word} was the word, guesser loses :-("
      true
    elsif !@board.include?("_")
      display
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

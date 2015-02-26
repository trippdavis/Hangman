require 'byebug'

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
    @word_length = word_length
    @possible_words = @dictionary.select { |word| word.length == @word_length }
  end

  def guess
    high_count = 0
    @guess = nil
    ("a".."z").to_a.each do |char|
      next if @guessed.include?(char)
      char_count = 0
      @possible_words.each do |word|
        char_count += word.count(char)
      end
      if char_count > high_count
        high_count = char_count
        @guess = char
      end
    end

    @guessed << @guess
    @guess
  end

  def reveal_word
    @secret_word
  end

  def get_locations(locations)
    locations.each do |loc|
      @possible_words = @possible_words.select{ |word| word[loc] == @guess }
    end
    @possible_words = @possible_words.select do |word|
      word.count(@guess) == locations.size
    end
  end
end

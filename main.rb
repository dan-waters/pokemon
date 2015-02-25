
require 'benchmark'
require_relative 'pokedex'
require_relative 'pokeset'

@start_time = Time.now

ALPHABET = 2**26 -1
@dex = Pokedex.new

@min_set = Pokeset.new(@dex.all)

def add_next_to_set(orig_set)
  @dex.map[(@dex.chars_order - orig_set.chars)[0]].each do |pokemon|
    new_set = Pokeset.new(orig_set.set + [pokemon])
    if new_set.code == ALPHABET && new_set <= @min_set
      @min_set = new_set
      puts "new min_set: #{new_set}"
    elsif new_set.code < ALPHABET && new_set.length < @min_set.length && (new_set.total_length + new_set.missing_char_count) < @min_set.total_length
      add_next_to_set(new_set)
    elsif new_set.code < ALPHABET || new_set > @min_set
      next
    end
  end
end

@dex.map[@dex.chars_order[0]].each do |pokemon|
  set = Pokeset.new([pokemon])
  if set.code < ALPHABET
    add_next_to_set(set)
  end
end

puts "min_set: #{@min_set}, found in #{Time.now - @start_time} seconds"

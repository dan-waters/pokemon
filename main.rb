require_relative 'pokedex'
require_relative 'pokeset'

@start_time = Time.now

ALPHABET = 2**26 - 1
@dex = Pokedex.new('pokemon.txt')

@min_set = Pokeset.new(@dex.all)

def room_for_two_more(set)
  set.length + 1 < @min_set.length
end

def room_for_one_more(set)
  (set.length + 1 == @min_set.length && (set.total_length + set.missing_char_count) <= @min_set.total_length)
end

def new_min_set(set)
  @min_set = set
  puts "new min_set: #{set}, found in #{Time.now - @start_time} seconds"
end

def add_next_to_set(orig_set)
  @dex.map[(@dex.chars_order - orig_set.chars)[0]].each do |pokemon|
    new_set = Pokeset.new(orig_set.set + [pokemon])
    if new_set.code == ALPHABET
      if new_set <= @min_set
        new_min_set(new_set)
      else
        next
      end
    elsif room_for_two_more(new_set) || room_for_one_more(new_set)
      add_next_to_set(new_set)
    else
      next
    end
  end
end

threads = []
@dex.map[@dex.chars_order[0]].each do |pokemon|
  threads << Thread.new do
    set = Pokeset.new([pokemon])
    if set.code < ALPHABET
      add_next_to_set(set)
    end
  end
end

threads.each{|t| t.join}

puts "min_set: #{@min_set}, found in #{Time.now - @start_time} seconds"
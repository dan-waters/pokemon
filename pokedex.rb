require 'json'
require 'open-uri'
require_relative 'pokemon'

class Pokedex
  def initialize
    @all = []
    @map = {}
    JSON.parse(open('pokemon.txt').read).map do |p|
      pokemon = Pokemon.new(p)
      @all << pokemon
      pokemon.unique_chars.each do |char|
        if @map.include?(char)
          @map[char] << pokemon unless @map[char].include?(pokemon)
        else
          @map[char] = [pokemon]
        end
      end
    end
    @map = Hash[@map.sort_by { |k, v| v.length }]
    @map.each do |k, v|
      @map[k] = v.sort { |a, b| (a.usefulness(chars_order) <=> b.usefulness(chars_order))}
    end
  end

  def all
    @all
  end

  def map
    @map
  end

  def chars_order
    @map.keys
  end
end
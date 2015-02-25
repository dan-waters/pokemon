class Pokemon
  def initialize(name)
    @name = name.downcase
  end

  def name
    @name
  end

  def unique_chars
    @unique_chars ||= chars.uniq
  end

  def chars
    @chars ||= name.chars.select { |char| char =~ /[a-z]/ }.map { |char| 2 ** (char.bytes.first - 97) }
  end

  def length
    @length ||= @name.length
  end

  def code
    @code ||= begin
      code = 0
      unique_chars.each do |char|
        code |= char
      end
      code
    end
  end

  def usefulness(order_map)
    @usefulness ||= chars.map { |ch| order_map[ch] }.inject(:+)
  end

  def to_s
    @string||= "#{@name}. Code: #{code}"
  end
end
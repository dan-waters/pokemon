class Pokeset
  include Comparable

  def initialize(set = [])
    @set = set
  end

  def <=>(other)
    if other.nil?
      1
    elsif length != other.length
      length <=> other.length
    elsif total_length != other.total_length
      total_length <=> other.total_length
    else
      0
    end
  end

  def code
    @code ||= begin
      code = 0
      @set.map(&:code).each { |c| code |= c }
      code
    end
  end

  def chars
    @chars ||= @set.map(&:unique_chars).flatten.uniq
  end

  def length
    @length ||= @set.length
  end

  def total_length
    @total_length ||= @set.map(&:name).join.length
  end

  def set
    @set
  end

  def to_s
    "#{@set.join ', '}, for a total length of #{length} pokemon and #{total_length} characters"
  end

  def missing_char_count
    @missing_char_count ||= 26 - chars.length
  end
end
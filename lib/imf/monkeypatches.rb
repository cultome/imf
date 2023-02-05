class String
  def to_pascalcase
    split('_')
      .map { |word| word[0].upcase + word[1..].downcase }
      .join
  end

  def to_singular
    gsub(/s$/, '')
  end
end

class Symbol
  def to_pascalcase
    to_s.to_pascalcase
  end

  def to_singular
    to_s.to_singular
  end
end

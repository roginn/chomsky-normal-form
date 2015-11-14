class GrammarSymbol
  attr_reader :label

  def initialize(label)
    @label = label
  end

  def to_s
    @label
  end

  def ==(other)
    self.to_s == other.to_s
  end

  def terminal?
    false
  end

  def empty_symbol?
    false
  end
end

class GrammarSymbol
  attr_reader :label

  def initialize(label)
    @label = label
  end

  def terminal?
    false
  end
end

class ProductionRule
  attr_reader :rhs, :lhs

  def initialize(lhs, rhs)
    @lhs, @rhs = lhs, rhs
  end

  def to_s
    "#{lhs.to_s} -> #{rhs.join(' | ')}"
  end
end

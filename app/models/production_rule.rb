class ProductionRule
  attr_accessor :rhs, :lhs

  def initialize(lhs, rhs)
    @lhs, @rhs = lhs, rhs
  end

  def to_s
    "#{lhs.to_s} -> #{rhs.join(' | ')}"
  end

  def deep_dup
    ProductionRule.new(lhs.dup, rhs.dup)
  end
end

class ProductionRule
  attr_reader :rhs, :lhs

  def initialize(lhs, rhs)
    @lhs, @rhs = lhs, rhs
  end
end

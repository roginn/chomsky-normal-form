class ProductionRuleParser
  attr_reader :lhs, :rhs

  def initialize(lhs, rhs)
    @lhs, @rhs = lhs, rhs
  end

  def parse
    check_validation
    ProductionRule.new(lhs, rhs)
  end

  protected
  def check_validation
    ProductionRuleValidator.new(self).check
  end
end

class GrammarConverter
  attr_reader :production_rules, :lhs_symbols, :rhs_strings

  def initialize(production_rules)
    @production_rules = production_rules
    @lhs_symbols = Hash.new { |h, k| h[k] = [] }
    @rhs_strings = Hash.new { |h, k| h[k] = [] }
    compute_strings
  end

  def compute_strings
    @production_rules.each do |rule|
      @lhs_symbols[rule.lhs.to_s] << rule
      rule.rhs.each do |string|
        @rhs_strings[string.to_s] << rule
      end
    end
  end
end

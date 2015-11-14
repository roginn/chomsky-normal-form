class Grammar
  attr_reader :production_rules, :lhs_symbols, :rhs_strings

  def initialize(production_rules)
    @production_rules = production_rules
    compute_rule_map
  end

  def compute_rule_map
    @lhs_symbols = Hash.new { |h, k| h[k] = [] }
    @rhs_strings = Hash.new { |h, k| h[k] = [] }

    @production_rules.each do |rule|
      @lhs_symbols[rule.lhs.to_s] << rule
      rule.rhs.each do |string|
        @rhs_strings[string.to_s] << rule
      end
    end
  end

  def start_symbol
    @start_symbol ||= @production_rules[0].lhs
  end

  def deep_dup
    Grammar.new @production_rules.map { |pr| pr.dup }
  end

  def to_s
    @production_rules.map { |pr| pr.to_s }.join("\n")
  end
end

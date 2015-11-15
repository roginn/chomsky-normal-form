class Grammar
  attr_reader :lhs_symbols, :rhs_strings, :all_nonterminals
  attr_accessor :production_rules

  #TODO validation: every RHS nonterminal should appear on the LHS

  def initialize(production_rules)
    @production_rules = production_rules
    compute_rule_map
  end

  def compute_rule_map
    @lhs_symbols = Hash.new { |h, k| h[k] = [] }
    @rhs_strings = Hash.new { |h, k| h[k] = [] }
    @all_nonterminals = Set.new

    @production_rules.each do |rule|
      @lhs_symbols[rule.lhs.to_s] << rule
      @all_nonterminals << rule.lhs.to_s

      rule.rhs.each do |string|
        @rhs_strings[string.to_s] << rule
        string.symbols.each do |symbol|
          @all_nonterminals << symbol.to_s unless symbol.terminal?
        end
      end
    end
  end

  def start_symbol
    @start_symbol ||= @production_rules[0].lhs
  end

  def deep_dup
    Grammar.new @production_rules.map { |pr| pr.deep_dup }
  end

  def to_s
    @production_rules.map { |pr| pr.to_s }.join("\n")
  end
end

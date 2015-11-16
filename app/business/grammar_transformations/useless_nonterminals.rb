module GrammarTransformations
  class UselessNonterminals
    def initialize(grammar)
      @grammar = grammar.deep_dup
      @used_symbols = Set.new ['S0']
    end

    def transformed
      collect_used_rules
      remove_unused_rules
      @grammar
    end

    protected
    def collect_used_rules
      @grammar.production_rules.each do |rule|
        rule.rhs.each do |string|
          string.each do |symbol|
            @used_symbols << symbol.to_s unless symbol.terminal?
          end
        end
      end
    end

    def remove_unused_rules
      to_be_removed = []
      @grammar.production_rules.each do |rule|
        to_be_removed << rule unless rule.lhs.to_s.in? @used_symbols
      end
      to_be_removed.each do |rule|
        @grammar.production_rules.delete rule
      end
    end
  end
end

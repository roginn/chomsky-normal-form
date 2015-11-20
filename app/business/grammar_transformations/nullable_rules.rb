module GrammarTransformations
  class NullableRules
    def initialize(grammar)
      @grammar = grammar.deep_dup
      @nullable_nonterminals = Set.new
    end

    def transformed
      list_nullable_nonterminals
      modify_nullable_rules
      remove_empty_strings
      @grammar
    end

    # protected
    def list_nullable_nonterminals
      begin
        found_nullable = false
        @grammar.production_rules.each do |rule|
          if nullable_rule?(rule) and !rule.lhs.start_symbol? and !nullable?(rule.lhs)
            # puts "FOUND NULLABLE:"
            # puts rule.lhs
            @nullable_nonterminals << rule.lhs.to_s
            found_nullable = true
          end
        end
      end while found_nullable
    end

    def modify_nullable_rules
      @grammar.production_rules.each do |rule|
        new_strings = []
        rule.rhs.each do |string|
          if contains_nullable? string
            new_strings += omitted_nullables string
          end
        end
        # puts "RULE: #{rule.to_s}"
        # puts "GENERATED STRINGS:"
        # puts new_strings.map(&:to_s).join("\n")
        new_strings.each do |string|
          rule.rhs = rule.rhs.dup
          rule.rhs << string unless string.to_s.in? rule.rhs.map(&:to_s)
        end
        # puts "NOW RULE IS: #{rule.to_s}"
      end
    end

    def remove_empty_strings
      @grammar.production_rules.each do |rule|
        next if rule.lhs.start_symbol?
        rule.rhs.select { |s| s.empty_string? }.each do |es|
          rule.rhs.delete es
        end
      end
    end

    def nullable?(symbol)
      symbol.to_s.in? @nullable_nonterminals
    end

    def nullable_rule?(rule)
      rule.rhs.each do |string|
        if string.all? { |symbol| nullable? symbol } or string.empty_string?
          return true
        end
      end
      false
    end

    def contains_nullable?(string)
      string.any? { |symbol| nullable? symbol }
    end

    def omitted_nullables(string)
      nullable_combinations(string).map do |a|
        a.any? ? NonemptyString.new(a) : EmptyString.new([EmptySymbol.new('_')])
      end
    end

    def nullable_combinations(string)
      # generates all combinations with and without nullable nonterminals
      combinations = []
      if string.size == 0
        return [[]]
      else
        first_symbol = string[0]
        y = string[1..-1]
        nullable_combinations(y).each do |z|
          combinations << z if nullable?(first_symbol)
          combinations << [first_symbol] + z
        end
      end
      combinations
    end
  end
end

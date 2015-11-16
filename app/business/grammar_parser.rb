class GrammarParser
  attr_reader :errors

  def initialize(text)
    @text = text
    @errors = []
    @production_rules = []
  end

  def parse
    @text.split("\n").each_with_index do |line, line_idx|
      begin
        @production_rules << parse_string(line)
      rescue Exception => e
        errors << {
          exception: e,
          line: line_idx + 1
        }
      end
    end

    errors.present? ? nil : Grammar.new(@production_rules)
  end

  protected
  def parse_string(string)
    lhs_token, rhs_tokens = TokenParser.new(string).parse
    lhs_symbol  = SymbolParser.new(lhs_token).parse.first
    rhs_symbols = rhs_tokens.map { |rt| SymbolParser.new(rt).parse }
    rhs_strings = rhs_symbols.map { |rs| StringParser.new(rs).parse }
    ProductionRuleParser.new(lhs_symbol, rhs_strings).parse
  end
end

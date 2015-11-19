class GrammarsController < ApplicationController
  def index
    @example_grammar = <<-EOS
S -> A | b | aB
A -> a | aBa | _
B -> b | bAb
    EOS
  end

  def post
    input_grammar = params[:grammar][:grammar]
    parser = GrammarParser.new(input_grammar)
    @grammar = parser.parse
    if @grammar.present?
      gc = GrammarConverter.new(@grammar)
      @results = gc.results
    else
      @errors = parser.errors.to_s
    end
  end
end

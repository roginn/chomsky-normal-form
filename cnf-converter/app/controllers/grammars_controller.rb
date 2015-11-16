class GrammarsController < ApplicationController
  def index
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

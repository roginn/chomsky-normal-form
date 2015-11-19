class GrammarsController < ApplicationController
  def index
    @example_grammar = <<-EOS
S -> A | b | aB
A -> a | aBa | _
B -> b | bAb
    EOS
  end

  def convert
    @transformation_names = [
      'Gramática inicial',
      'Eliminação de recursão sobre S',
      'Eliminação de regras com símbolos terminais não solitários',
      'Eliminação de regras com mais de 2 símbolos não-terminais do lado direito',
      'Eliminação de regras ε',
      'Eliminação de produções unitárias',
      'Eliminação de Símbolos Inúteis'
    ]

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

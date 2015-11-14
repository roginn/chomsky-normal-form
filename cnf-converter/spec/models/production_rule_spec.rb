require 'rails_helper'

RSpec.describe ProductionRule do
  let(:nts) { NonterminalSymbol.new('A') }
  let(:ts)  { TerminalSymbol.new('a') }
  let(:gs)  { GrammarString.new([nts, ts]) }

  it 'should accept a nonterminal symbol as lhs' do
    expect { ProductionRule.new(nts, gs) }.to_not raise_error
  end

  it 'should raise if lhs is not a nonterminal' do
    expect { ProductionRule.new(gs, gs)}.to raise_error
  end
end

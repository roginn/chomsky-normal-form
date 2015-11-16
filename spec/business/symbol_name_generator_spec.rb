require 'rails_helper'

RSpec.describe SymbolNameGenerator do
  let(:sng) { SymbolNameGenerator.new }

  it 'generates simple names' do
    expect(sng.terminal).to eq('a')
  end

  it 'takes restrictions into account' do
    expect(sng.terminal %w[a b c e f g]).to eq('d')
  end

  it 'iterates number until a viable name is found' do
    restrictions = (1..3).inject([]) do |acc, i|
      acc + (('A'..'Z').to_a + ('0'..'9').to_a).repeated_permutation(i).to_a.map { |x| x.join }
    end

    expect(sng.nonterminal restrictions).to eq('A100')
  end
end

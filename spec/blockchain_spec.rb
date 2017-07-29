require_relative 'spec_helper'
require_relative '../lib/blockchain'

describe Blockchain do
  before do
    @blockchain = Blockchain.new
  end

  it 'has a genesis block' do
    @blockchain.genesis_block.hash.must_equal(
      '00006b1133255a73e1b6ba84e609fee0e4ca3356f0ab862f2a3e597a40693061'
    )
  end
end

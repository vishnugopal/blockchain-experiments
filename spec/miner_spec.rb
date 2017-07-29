require_relative 'spec_helper'
require_relative '../lib/miner'

describe Miner do
  before do
    @block_header = BlockHeader.new(
      previous_block_hash: 'x',
      merkle_root: 'y',
      timestamp: 'z',
      difficulty_target: 3,
      nonce: 'b'
    )
  end

  it 'accepts a BlockHeader' do
    proc {
      Miner.new(block_header: '')
    }.must_have_error(/block header/, ArgumentError)
    Miner.new(block_header: @block_header)
  end

  it 'mines for a block hash based on the difficulty target' do
    miner = Miner.new(block_header: @block_header)
    result = miner.mine
    result[:hash][0..@block_header.difficulty_target - 1].must_equal(
      '0' * @block_header.difficulty_target
    )
    result[:block_header].nonce.length.must_equal(
      Miner::NONCE_LENGTH
    )
  end
end

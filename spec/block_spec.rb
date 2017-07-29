require_relative 'spec_helper'
require_relative '../lib/block'

describe Block do
  before do
    @block_header = BlockHeader.new(
      previous_block_hash: 'x',
      merkle_root: 'y',
      timestamp: 'z',
      difficulty_target: 'a',
      nonce: 'b'
    )

    @transaction_tree = TransactionTree.new
    @transaction = Transaction.new
    @transaction << { input: TransactionInput.new(utxo_transaction_hash: 'x', signature: 'y') }
    @transaction << { output: TransactionOutput.new(amount: 25, public_key: 'x') }
  end

  it 'constructs & serializes a block header' do
    @block_header.serialize.must_equal({
        :previous_block_hash=>"x",
        :merkle_root=>"y",
        :timestamp=>"z",
        :difficulty_target=>"a",
        :nonce=>"b"
      }.to_json
    )
  end

  it 'constructs a block with header and transactions' do
    block = Block.new(block_header: @block_header, transaction_tree: @transaction_tree)
    proc {
      Block.new(block_header: @block_header, transaction_tree: [])
    }.must_have_error(/transaction tree/, ArgumentError)
    proc {
      Block.new(block_header: '', transaction_tree: @transaction_tree)
    }.must_have_error(/block header/, ArgumentError)
  end
end

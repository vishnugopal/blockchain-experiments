require_relative 'transaction_tree'
require 'json'

class Block
  def initialize(block_header:, transaction_tree:)
    raise ArgumentError, 'block header is invalid' unless
      block_header.is_a? BlockHeader
    raise ArgumentError, 'transaction tree is invalid' unless
      transaction_tree.is_a? TransactionTree
  end
end

class BlockHeader
  attr_accessor :previous_block_hash, :merkle_root, :timestamp,
                :difficulty_target, :nonce

  def initialize(previous_block_hash:, merkle_root:, timestamp:,
                 difficulty_target:, nonce:)
    @previous_block_hash = previous_block_hash
    @merkle_root = merkle_root
    @timestamp = timestamp
    @difficulty_target = difficulty_target
    @nonce = nonce
  end

  def serialize
    {
      previous_block_hash: @previous_block_hash,
      merkle_root: @merkle_root,
      timestamp: @timestamp,
      difficulty_target: @difficulty_target,
      nonce: @nonce
    }.to_json
  end
end

require_relative 'transaction_tree'
require 'json'

class Block
  attr_reader :parent, :children, :hash, :block_header, :transaction_tree

  def initialize(block_header:, transaction_tree:, hash:, parent: nil)
    raise ArgumentError, 'block header is invalid' unless
      block_header.is_a? BlockHeader
    raise ArgumentError, 'transaction tree is invalid' unless
      transaction_tree.is_a? TransactionTree

    @block_header = block_header
    @transaction_tree = transaction_tree
    @hash = hash
    self.parent = parent if parent
  end

  def parent=(parent)
    raise ArgumentError, 'parent is invalid' unless parent.is_a? Block
    raise Exception, 'parent is already set' if @parent

    @parent = parent
  end
end

class BlockHeader
  attr_accessor :previous_block_hash, :merkle_root, :timestamp,
                :difficulty_target, :nonce

  def initialize(previous_block_hash:, merkle_root:, timestamp:,
                 difficulty_target:, nonce: rand)
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

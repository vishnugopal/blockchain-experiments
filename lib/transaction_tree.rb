require_relative 'transaction'
require 'merkle-hash-tree'
require 'digest/sha2'

class TransactionTree
  def initialize
    @transactions = []
    @transactions_hash = []
    @tree = MerkleHashTree.new(@transactions, TransactionTreeDigest)
  end

  def <<(transaction)
    raise ArgumentError, 'transaction must be passed in' unless transaction.is_a? Transaction
    @transactions << transaction.serialize
    @transactions_hash << transaction.hash
  end

  def merkle_root_bytes
    @tree.head
  end

  def merkle_root
    merkle_root_bytes.unpack('H*')[0]
  end

  def serialize
    {
      merkle_root: merkle_root,
      transactions: @transactions_hash
    }.to_json
  end
end

class TransactionTreeDigest
  def self.digest(text)
    Digest::SHA2.digest(Digest::SHA2.digest(text))
  end
end

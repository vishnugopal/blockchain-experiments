
require_relative 'proof_worker'
require 'merkle-hash-tree'

class BlockMaker
  attr_reader :logger

  def initialize(options = {})
    @logger = Logger.new(options.delete(:logger) || STDOUT)
    @blockchain = Array.new
    @mht = MerkleHashTree.new(@blockchain, Digest::SHA2)
  end
  
  def work
    loop do
      mine_and_add_to_blockchain
    end
  end

  def mine_and_add_to_blockchain
    incoming_block = mine_new_block
    logger.info "Got new incoming block: #{incoming_block}"
    viable_hash = verify_hash(
      incoming_block[:random_seed], 
      incoming_block[:transactions], 
      incoming_block[:previous_block_id],
      incoming_block[:winning_hash])
    
    if viable_hash
      logger.info "Viable hash, adding to blockchain"
      add_block_to_blockchain(incoming_block) 
      logger.info "Current block length: #{blockchain_length}"
      logger.info "Current blockchain head: #{blockchain_hash}"
    else
      logger.error "Not viable hash! Discarding"
    end
  end
  
  def blockchain_hash
    Digest::SHA2.hexdigest(@mht.head)
  end
  
  def blockchain_length
    @blockchain.length
  end
  
  def mine_new_block
    p = ProofWorker.new
    p.pending_facts = [{hello: :world}]
    p.previous_block_id = @blockchain.length
    p.find
    { 
      previous_block_id: @blockchain.length, 
      transactions: [{hello: :world}], 
      winning_hash: p.winning_hash,
      random_seed: p.random_seed
    }
  end

  def verify_hash(random_seed, transactions, previous_block_id, winning_hash)
    difficulty = 3
    hash = Digest::SHA2.hexdigest(Digest::SHA2.hexdigest("#{random_seed}#{transactions.to_json}#{previous_block_id}"))
    winning_hash == hash && hash[0..(difficulty - 1)] == '0' * (difficulty)
  end

  def add_block_to_blockchain(block)
    @blockchain << block
  end
end

b = BlockMaker.new
b.work

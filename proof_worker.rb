require 'digest/sha2'
require 'json'
require 'logger'

class ProofWorker
  DEFAULT_DIFFICULTY = 3
  RANDOM_SEED_LENGTH = 100
  
  attr_reader :winning_hash, :logger, :pending_facts, :difficulty
  
  def initialize(pending_facts = [], options = {})
    raise ArgumentError, "Pending Facts must be an Array" unless pending_facts.is_a? Array

    @pending_facts = pending_facts.to_json
    @logger = Logger.new(options.delete(:logger) || STDOUT)
    @difficulty = options.delete(:difficulty) || DEFAULT_DIFFICULTY
  end
  
  def find
    hash = ""
    iteration = 1
    loop do 
      @logger.debug "Iteration: #{iteration}" if (iteration % 1000 == 0)
      hash = proof_of_work
      break if hash[0..(@difficulty - 1)] == "0" * (@difficulty)
      iteration += 1
    end
    
    @winning_hash = hash
    logger.info("Winning hash: #{self.winning_hash}")
  end

  def random_string(length = RANDOM_SEED_LENGTH)
    (1..length).inject("") do |a, i|
      (a ||= "") << ('a'..'z').to_a[rand(26)]
    end
  end

  def proof_of_work 
    Digest::SHA2.hexdigest(Digest::SHA2.hexdigest("#{random_string}#{self.pending_facts}"))
  end
end

proof = ProofWorker.new([{ amount: 10 }])
proof.find

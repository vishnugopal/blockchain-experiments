require 'digest/sha2'
require 'json'

class ProofWorker
  DIFFICULTY = 2
  RANDOM_SEED_LENGTH = 100
  
  attr_reader :winning_hash
  
  def initialize(pending_facts)
    raise ArgumentError, "Pending Facts must be an Array" unless pending_facts.is_a? Array
    @pending_facts = pending_facts.to_json
  end
  
  def find
    hash = ""
    loop do
      print "."
      hash = proof_of_work
      break if hash[0..(DIFFICULTY - 1)] == "0" * (DIFFICULTY)
    end
    @winning_hash = hash
  end

  def random_string(length = RANDOM_SEED_LENGTH)
    (1..length).inject("") do |a, i|
      (a ||= "") << ('a'..'z').to_a[rand(26)]
    end
  end

  def proof_of_work 
    Digest::SHA2.hexdigest(Digest::SHA2.hexdigest("#{random_string}#{@pending_facts}"))
  end
end

proof = ProofWorker.new([{ amount: 10 }])
proof.find
puts proof.winning_hash

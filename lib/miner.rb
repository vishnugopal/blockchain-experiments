require_relative 'block'

class Miner
  NONCE_LENGTH = 20

  def initialize(block_header:)
    raise ArgumentError, 'block header is invalid' unless block_header.is_a? BlockHeader
    @block_header = block_header
  end

  def mine
    hash = ""
    loop do
      hash = proof_of_work
      break if valid_hash?(hash)
    end

    {
      hash: hash,
      block_header: @block_header
    }
  end

  private

  def valid_hash?(hash)
    hash[0..(@block_header.difficulty_target - 1)] ==
      '0' * @block_header.difficulty_target
  end

  def nonce_string(length = NONCE_LENGTH)
    (1..length).inject("") do |a, i|
      (a ||= "") << ('a'..'z').to_a[rand(26)]
    end
  end

  def proof_of_work
    @block_header.nonce = nonce_string
    Digest::SHA2.hexdigest(Digest::SHA2.hexdigest(@block_header.serialize))
  end
end

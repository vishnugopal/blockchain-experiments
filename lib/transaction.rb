require 'json'

class Transaction  
  def initialize
    @inputs = []
    @outputs = []
  end
  
  def <<(output: nil, input: nil)
    if input
      unless input.is_a? TransactionInput or input.is_a? TransactionCoinbase
        raise ArgumentError, "input should either be of type TransactionInput or TransactionCoinbase"
      end
      
      @inputs << input
    end
    
    if output
      unless output.is_a? TransactionOutput
        raise ArgumentError, "output should a TransactionOutput"
      end
      @outputs << output
    end
  end
  
  def serialize
    @serialized_form = { inputs: [], outputs: [] }
    @inputs.each do |input|
      @serialized_form[:inputs] << input.serialize
    end
    @outputs.each do |output|
      @serialized_form[:outputs] << output.serialize
    end
    
    @serialized_form.to_json
  end
  
  def hash
    Digest::SHA2.digest(Digest::SHA2.digest(serialize)).unpack("H*")[0]
  end
end

class TransactionOutput
  attr_reader :amount, :public_key
  
  def initialize(amount:, public_key:)
    @amount = amount
    @public_key = public_key
  end
  
  def serialize
    {type: 'output', amount: amount, public_key: public_key}
  end
end

class TransactionInput
  attr_reader :utxo_transaction_hash, :signature
  
  def initialize(utxo_transaction_hash:, signature:)
    @utxo_transaction_hash = utxo_transaction_hash
    @signature = signature
  end
  
  def serialize
    {type: 'input', utxo_transaction_hash: utxo_transaction_hash, signature: signature}
  end
end

class TransactionCoinbase  
  def serialize
    {type: 'coinbase'}
  end
end
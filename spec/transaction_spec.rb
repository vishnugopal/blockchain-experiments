require_relative 'spec_helper'
require_relative '../lib/transaction'

describe Transaction do
  before do
    @transaction = Transaction.new
    @input = TransactionInput.new(utxo_transaction_hash: 'x', signature: 'y')
    @output = TransactionOutput.new(amount: 25, public_key: 'z')
    @coinbase = TransactionCoinbase.new
  end
  
  it 'has an array of inputs and outputs' do
    @transaction << { output: @output, input: @input }
    @transaction << { output: @output, input: @coinbase }
    @transaction << { input: @input }
    @transaction << { output: @output }
    proc {
      @transaction << { output: 'a', input: @input } 
    }.must_have_error(/output/, ArgumentError)
    proc {
      @transaction << { output: @output, input: 'a' } 
    }.must_have_error(/input/, ArgumentError)
  end
  
  it 'can return a serialized representation' do
    @transaction << { output: @output, input: @input }
    @transaction << { output: @output, input: @coinbase }
    @transaction << { input: @input }
    @transaction << { output: @output }
    @transaction.serialize.must_equal( 
      {
        :inputs => 
          [ 
            {:type=>"input", :utxo_transaction_hash=>"x", :signature=>"y"}, 
            {:type=>"coinbase"}, 
            {:type=>"input", :utxo_transaction_hash=>"x", :signature=>"y"}
          ], 
        :outputs => 
          [ 
            {:type=>"output", :amount=>25, :public_key=>"z"}, 
            {:type=>"output", :amount=>25, :public_key=>"z"}, 
            {:type=>"output", :amount=>25, :public_key=>"z"}
          ]
      }.to_json
    )
  end
end

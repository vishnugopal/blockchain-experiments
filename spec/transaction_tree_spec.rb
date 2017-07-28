require_relative 'spec_helper'
require_relative '../lib/transaction_tree'

describe TransactionTree do
  before do
    @transaction_tree = TransactionTree.new
    @transaction = Transaction.new
    @transaction << { input: TransactionInput.new(utxo_transaction_hash: 'x', signature: 'y') }
    @transaction << { output: TransactionOutput.new(amount: 25, public_key: 'x') }
  end
  
  it 'takes in an array of transactions' do
    @transaction_tree << @transaction
    @transaction_tree << @transaction
    @transaction_tree << @transaction
    @transaction_tree << @transaction
    proc {
      @transaction_tree << 'a'
    }.must_have_error(/transaction/, ArgumentError)
  end
  
  it 'can calculate the merkle root' do
    @transaction_tree << @transaction
    @transaction_tree << @transaction
    @transaction_tree << @transaction
    @transaction_tree << @transaction
    @transaction_tree.merkle_root.must_equal 'a531b69a207961fe55189ac542e8bf34ff42b73d957123ed065923ac608d0444'
  end
  
  it 'can generate a serialized version' do
    @transaction_tree << @transaction
    @transaction_tree << @transaction
    @transaction_tree << @transaction
    @transaction_tree << @transaction
    @transaction_tree.serialize.must_equal(
      {
        :merkle_root => "a531b69a207961fe55189ac542e8bf34ff42b73d957123ed065923ac608d0444", 
        :transactions=> ["2eee7e2a5a8e985f3f8d24076442e7110dcc7e59ff07c5f1790720323d599c95", "2eee7e2a5a8e985f3f8d24076442e7110dcc7e59ff07c5f1790720323d599c95", "2eee7e2a5a8e985f3f8d24076442e7110dcc7e59ff07c5f1790720323d599c95", "2eee7e2a5a8e985f3f8d24076442e7110dcc7e59ff07c5f1790720323d599c95"]
      }.to_json
    )
  end
end

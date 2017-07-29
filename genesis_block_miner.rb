require_relative 'lib/miner'
require_relative 'lib/key'
require_relative 'lib/block'

genesis_transactions = TransactionTree.new
genesis_transaction = Transaction.new

genesis_transaction_coinbase = TransactionCoinbase.new(message: '29/07/2017 https://www.theverge.com/2017/7/28/16058868/apple-nokia-patent-dispute-settlement-2-billion-dollars')
key = Key.new(name: 'vishnu')
key.generate
public_key = key.public_key_serialized
genesis_transaction_output = TransactionOutput.new(amount: 25, public_key: public_key)

genesis_transaction << { input: genesis_transaction_coinbase, output: genesis_transaction_output }
genesis_transactions << genesis_transaction

genesis_block_header = BlockHeader.new(
  previous_block_hash: nil,
  merkle_root: genesis_transactions.merkle_root,
  timestamp: Time.now,
  difficulty_target: 2
)

genesis_miner = Miner.new(block_header: genesis_block_header)
result = genesis_miner.mine

genesis_block_hash = result[:hash]
genesis_block_header = result[:block_header]

genesis_block = Block.new(
  block_header: genesis_block_header,
  transaction_tree: genesis_transactions,
  hash: genesis_block_hash,
  parent: nil
)

# p genesis_block.hash
# dump = Marshal::dump(genesis_block)
# p dump

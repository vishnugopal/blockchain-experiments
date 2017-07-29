# Blockchain in Ruby

This is a simple, cleanroom implementation of Blockchain in Ruby with minimal dependencies. This is CURRENTLY BROKEN. See TODO.

## TODO

* Write a Key class to model Public/Private ownership
  * name ✔︎
  * Generate signatures from keys ✔︎
  * & verify em ✔︎
  * TODO: serialize to file.
  * See: https://github.com/augustl/ruby-openssl-cheat-sheet
* Write a Transaction class to model everything in Transactions
  * Transaction Structure
    * Inputs ✔︎
    * Outputs ✔︎
  * Transaction Output (UTXO)
    * Amount ✔︎
    * Public key ✔︎
  * Transaction Input (Transactions to spend)
    * Transaction hash of UTXO ✔︎
    * Signature ✔︎
  * Coinbase Transaction (This is how coins are awarded during mining)
    * Transaction Input does not have signature or transaction hash, instead is marked coinbase. ✔︎
    * Transaction Output is the same. ✔︎
  * Serialize a transaction so that a hash can be generated ✔︎
  * See also: http://chimera.labs.oreilly.com/books/1234000001802/ch05.html#tx_inputs_outputs
  * Transaction Fee = Inputs - Outputs (excluding Coinbase)
  * Transaction Net Credit = Transaction Fee + Coinbase
* Write a MerkleTreeGenerator to generate a Merkle tree from a set of transactions. This should be doable using the merkle-hash-tree gem. ✔︎
  * Make the MerkleTree Structure serializable. ✔︎
* Build a Block ✔︎
  * Block Header ✔︎
  * Transactions ✔︎
  * Also build the Genesis Block
  * see: http://chimera.labs.oreilly.com/books/1234000001802/ch07.html
* Build a BlockChain
  * Parent -> Child, Child. but Child -> Parent
  * longest_chain ..?
  * load and save to file?
* Build a Miner, and needs to be tweaked slightly to include Previous Block Hash, Merkle Root, Timestamp, Difficulty Target, Nonce. See: http://chimera.labs.oreilly.com/books/1234000001802/ch07.html#block_header
  * Tweak difficulty based on mining time.

* Now, proceed to write daemons that talk to each other.

* Explore Multicast for simple local-network communication: https://github.com/jpignata/blog/blob/master/articles/multicast-in-ruby.md

* Build a TransactionValidator
  * Validates transactions
    * http://chimera.labs.oreilly.com/books/1234000001802/ch08.html#tx_verification
  * Records them in the transaction pool
  * Add UTXOs to UTXO pool and marks them as spent or not.

* Build a BlockAggregator
  * Validates new blocks: http://chimera.labs.oreilly.com/books/1234000001802/ch08.html#_validating_a_new_block
  * Validates each transaction using TransactionValidator
  * Handle case of forks
    * & reconvergence

* Build a TransactionConfirmationChecker
  * Go through the Blockchain and Merkle trees to check whether a transaction has been verified (6 block deep verifications)
* Build a CLI
  * to connect to the running daemon and check for status, generate transactions etc.

* Other resources:
  * https://marmelab.com/blog/2016/04/28/blockchain-for-web-developers-the-theory.html
  * Merkle Trees: http://www.certificate-transparency.org/log-proofs-work
    * In Ruby: https://github.com/mpalmer/merkle-hash-tree

require_relative 'block'

class Blockchain
  def initialize
    @blocks = []
  end

  def <<(block)
    @blocks << block
  end

  def blocks
    [genesis_block] + @blocks
  end

  def genesis_block
    Marshal::load("\x04\bo:\nBlock\t:\x12@block_headero:\x10BlockHeader\n:\x19@previous_block_hash0:\x11@merkle_rootI\"Ecbc889565864b55dc1617f60b031eb107b916647c34922439e4cde7774c1e597\x06:\x06EF:\x0F@timestampIu:\tTime\r\xB1[\x1D\x80\ek\xE2\x10\a:\voffseti\x02XM:\tzoneI\"\bIST\x06;\nF:\x17@difficulty_targeti\a:\v@nonceI\"\x19lpjreofcqlwpordqbaqw\x06;\nT:\x16@transaction_treeo:\x14TransactionTree\b:\x12@transactions[\x06I\"\x02\xA1\x02{\"inputs\":[{\"type\":\"coinbase\",\"message\":\"29/07/2017 https://www.theverge.com/2017/7/28/16058868/apple-nokia-patent-dispute-settlement-2-billion-dollars\"}],\"outputs\":[{\"type\":\"output\",\"amount\":25,\"public_key\":\"-----BEGIN PUBLIC KEY-----\\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5qkEzM5tAHd5LyfUzk7n\\nf3XaRlxdNK0ROI1jhXGkJu4SXxcGBDdtR+R7ZlapMX03kM7tOB4icvEVeERoX70F\\n4pNA0W0TNrZ1bU3pU922H6NymnYAIpiAR3bx23QK/mUGLZbqiR0ZEsjtSw4Z00hc\\nwxfVEhZZ7dMyEdTdVLkirNiM3rV4y1GnB1ekAQ2JBXiE2aZtC1cRQg7OTj/BSb33\\nTG+llqC6i7gshi78a87Df8X/Z5nosbTV8oPVSyYeBf4f+2F6gRhMZ2BY0fpJBxSE\\nXkcKK6XLt7TqYAlEDyRjRCTETw6DvgiWWx0XxI7D5G21lWBLoUyuBEpwwMkDBZSL\\nbwIDAQAB\\n-----END PUBLIC KEY-----\\n\"}]}\x06;\nT:\x17@transactions_hash[\x06I\"E3e32e5bd511e5ec5b731c990bbd6b89e87ee2094fe1478fd05fe2b3c5f958925\x06;\nF:\n@treeo:\x13MerkleHashTree\a:\n@data@\f:\f@digestc\x1ATransactionTreeDigest:\n@hashI\"E00006b1133255a73e1b6ba84e609fee0e4ca3356f0ab862f2a3e597a40693061\x06;\nF:\x0E@children[\x00")
  end
end


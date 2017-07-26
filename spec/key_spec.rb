require_relative 'spec_helper'
require_relative '../lib/key'

describe Key do
  before do
    @key = Key.new(name: 'vishnu')
  end
  
  it 'can generate a keypair' do
    @key.generate
  end
  
  it 'can generate a signature' do
    @key.generate
    @key.signature.length.must_equal 256
  end
  
  it 'can verify a signature' do
    @key.generate
    signature = @key.signature
    
    # Now using just the serialized public key and the signature, verify it.    
    public_key_serialized = @key.public_key_serialized
    verification = Key.verify signature: signature, public_key_serialized: public_key_serialized
    verification.must_equal true
  end
end
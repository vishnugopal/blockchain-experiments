require 'openssl'

class Key
  attr_reader :public_key, :public_key_serialized

  def initialize(name:)
    @name = name
  end
  
  def generate
    @rsa_key = OpenSSL::PKey::RSA.new(2048)
    @public_key = @rsa_key.public_key
  end
  
  def signature
    raise Exception, "Not available until key has been generated" unless @rsa_key
    
    digest = OpenSSL::Digest::SHA256.new
    @rsa_key.sign digest, self.public_key_serialized
  end
  
  def public_key_serialized
    raise Exception, "Not available until key has been generated" unless @rsa_key
    @rsa_key.public_key.to_pem
  end
  
  def self.verify(public_key_serialized:, signature:)
    digest = OpenSSL::Digest::SHA256.new
    
    public_key = OpenSSL::PKey::RSA.new(public_key_serialized)
    raise ArgumentError, "Public Key not present in serialized form" unless public_key.public?
    public_key.verify digest, signature, public_key_serialized
  end
end
class TokenService
  def self.create_for(entity, token_key)
    SecureRandom.hex.tap do |token|
      return create_for(entity, token_key) if entity.class.exists?(token_key => token)
      token
    end
  end
end

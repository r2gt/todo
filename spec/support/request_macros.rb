module RequestMacros
  def basic_headers
    {
      "Accept"             => Mime[:json].to_s,
      "Content-type"       => Mime[:json].to_s,
      'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.
                            encode_credentials(user.api_token)
    }
  end

  def user
    @user ||= User.create(
      name: 'Teste', username: 'teste', email: 'foo@bar.com', password: 'teste'
    )
  end
end
Main.set :oauth, OAuth::Consumer.new(
  'token',
  'secret',
  { site: 'https://www.google.com',
    request_token_path: '/accounts/OAuthGetRequestToken',
    access_token_path:  '/accounts/OAuthGetAccessToken',
    authorize_path:     '/accounts/OAuthAuthorizeToken'
  })

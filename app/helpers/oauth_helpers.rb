module OAuthHelpers
  def oauth_callback_url
    "http://#{request.env['HTTP_HOST']}/login/google/continue"
  end

  def oauth_request_token
    Main.oauth.get_request_token(
      {oauth_callback: oauth_callback_url},
      {scope: 'http://www.google.com/reader/api/*'})
  end

  def oauth_access_token(options={})
    rt = oauth_request_token
    rt.get_access_token
  end
end

Main.helpers OAuthHelpers

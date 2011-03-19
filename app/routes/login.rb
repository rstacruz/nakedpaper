class Main
  before do
    unless request.fullpath =~ /^\/(auth|login|css|js|mockups|mockup)/ || request.fullpath == '/'
      require_login
    end
  end

  get '/login' do
    haml :'home/login'
  end

  post '/login' do
    if authenticate(params)
      redirect '/'
    else
      session[:error] = "Try again."
      redirect R(:login)
    end
  end

  get '/auth/:name/callback' do
    p request.env['omniauth.auth']
    token = request.env['omniauth.auth']['extra']['access_token']
    p token.get('http://www.google.com/reader/api/0/token').body
    authenticate access_token: token
    redirect '/'
  end

  get '/auth/failure' do
    redirect R(:login)
  end
end

class Main
  before do
    unless request.fullpath =~ /^\/(auth|login|logout|page|about|css|js|mockups|mockup)/ || request.fullpath == '/'
      require_login
    end
  end

  get '/login' do
    haml :'home/login'
  end

  post '/login' do
    if authenticate(params)
      redirect next_url
    else
      session[:error] = "Try again."
      redirect R(:login)
    end
  end

  post '/logout' do
    logout!
    redirect '/'
  end

  get '/auth/:name/callback' do
    omni  = request.env['omniauth.auth']
    token = omni['extra']['access_token']

    if authenticate('email' => omni['uid'], 'access_token' => token)
      redirect next_url
    else
      session[:error] = "OAuth failed (1)."
      redirect R(:login)
    end
  end

  get '/auth/failure' do
    session[:error] = "OAuth failed (2)."
    redirect R(:login)
  end
end

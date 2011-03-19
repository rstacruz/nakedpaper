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
    omni  = request.env['omniauth.auth']
    token = omni['extra']['access_token']

    if authenticate('email' => omni['uid'], 'access_token' => token)
      redirect '/'
    else
      session[:error] = "OAuth failed."
      redirect R(:login)
    end
  end

  get '/auth/failure' do
    session[:error] = "OAuth failed."
    redirect R(:login)
  end
end

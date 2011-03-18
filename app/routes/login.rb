class Main
  before do
    unless request.fullpath =~ /^\/(login|css|js|mockups|mockup)/ || request.fullpath == '/'
      require_login
    end
  end

  get '/login' do
    haml :login
  end

  post '/login' do
    if authenticate(params)
      redirect '/'
    else
      session[:error] = "Try again."
      redirect R(:login)
    end
  end
end

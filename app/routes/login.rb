class Main
  before do
    unless request.fullpath =~ /^\/(login|css|js|mockups|mockup)/ || request.fullpath == '/'
      p logged_in?
      require_login
    end
  end

  get '/login' do
    haml :login
  end

  post '/login' do
    if authenticate(params)
      redirect '/dashboard'
    else
      session[:error] = "Try again."
      redirect '/login'
    end
  end
end

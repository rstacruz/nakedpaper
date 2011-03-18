class Main
  before do
    unless request.fullpath =~ %r{\A/(login|css|js|mockups|mockup)?}
      puts "HAHA"
      require_login
    end

    #client.expire!  if params[:expire] && client
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

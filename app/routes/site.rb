class Main
  get '/' do
    if logged_in?
      haml :dashboard
    else
      redirect R(:login)
    end
  end
end


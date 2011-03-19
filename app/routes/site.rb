class Main
  get '/' do
    if logged_in?
      haml :'news/dashboard'
    else
      redirect R(:login)
    end
  end
end


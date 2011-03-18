class Main
  get '/' do
    if logged_in?
      redirect R(:dashboard)
    else
      redirect R(:login)
    end
  end
end


class Main
  get '/' do
    if logged_in?
      haml :'news/dashboard'
    else
      redirect R(:login)
    end
  end

  get '/about' do
    file  = Main.root('ABOUT.textile')
    @text = textile File.read(file)

    haml :'site/about'
  end
end


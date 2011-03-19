module LoginHelpers
  def authenticate(options)
    session[:client] ||= if options['password']
      GReader.auth email: options['email'], password: options['password']
    else
      GReader.auth email: options['email'], access_token: options['access_token']
    end

    logged_in?
  end

  def logged_in?
    ! client.nil?
  end

  def require_login
    redirect R(:login, next: request.fullpath)  unless logged_in?
  end

  def client
    session[:client]
  end
end

Main.helpers LoginHelpers

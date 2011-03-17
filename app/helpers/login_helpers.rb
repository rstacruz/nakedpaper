module LoginHelpers
  def authenticate(options)
    session[:client] ||= GReader.auth(email: options['username'], password: options['password'])

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

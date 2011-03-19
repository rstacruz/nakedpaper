module LoginHelpers
  def authenticate(options)
    if options['username']
      session[:client] ||= GReader.auth(email: options['username'], password: options['password'])
    else
      session[:client] ||= GReader.auth(access_token: options[:access_token])
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

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

  def next_url
    params[:next] || '/'
  end

  def require_login
    return true  if logged_in?

    if request.xhr?
      status 401
    else 
      redirect R(:login, next: request.fullpath)
    end
  end

  def client
    session[:client]
  end
end

Main.helpers LoginHelpers

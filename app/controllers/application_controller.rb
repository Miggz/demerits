class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def self.load_polymorphic_from_url(symbol, options = {})
    before_filter(options) do |c|
      if c.params[:id].present?
        obj = c.controller_path.classify.constantize
               .find(params[:id]).send(symbol)
      else
        resource, id = c.request.path.split('/')[1, 2]
        obj = resource.classify.constantize.find(id)
      end
      c.instance_variable_set "@#{symbol}".to_sym, obj
    end
  end

  def set_user
    @user = current_user
  end

  def require_user
    unless current_user
      store_location
      flash[:alert] = t "authlogic.require_user"
      redirect_to login_path
      false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:alert] = t "authlogic.require_no_user"
      redirect_to root_path
      false
    end
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def store_location(url = nil)
    url ||= request.url
    store_session :return_to, url
  end

  def store_session(key, value)
    session[key] = value if value.present?
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end

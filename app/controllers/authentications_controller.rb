class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env['omniauth.auth']
    authentication = Authentication.find_by omniauth.slice(:provider, :uid)
    if authentication
      flash[:notice] = 'Signed in successfully.'
      login(authentication.user)
    elsif current_user
      current_user.create_authentication omniauth
      flash[:notice] = 'Authentication successful.'
      redirect_to root_path
    else
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice] = 'Signed in successfully.'
        login(user)
      end
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = 'Successfully destroyed authentication.'
    redirect_to login_path
  end

  private

  def login(user)
    UserSession.create(user)
    redirect_to root_path
  end
end

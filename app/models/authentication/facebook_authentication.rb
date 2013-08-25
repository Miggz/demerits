class FacebookAuthentication < Authentication
  def dsl
    proc do
      defaults :uid, :provider
      traverse :info do
        defaults :name, :email, :image
      end
    end
  end
end

class FacebookAuthentication < Authentication
  def dsl
    proc do
      traverse :info do
        defaults :name, :email, :image
      end
    end
  end
end

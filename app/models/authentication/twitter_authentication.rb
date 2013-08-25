class TwitterAuthentication < Authentication
  def dsl
    proc do
      defaults :uid, :provider
      traverse :info do
        defaults :name, :image
      end
    end
  end
end

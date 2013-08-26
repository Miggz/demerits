class TwitterAuthentication < Authentication
  def dsl
    proc do
      traverse :info do
        defaults :name, :image
      end
    end
  end
end

class Authentication < ActiveRecord::Base
  belongs_to :user

  validates :uid, uniqueness: { scope: :provider }

  PROVIDERS = %w(twitter facebook)

  def provider_name
    provider.titleize
  end

  def dsl
    raise 'This method should be overriden in subclass'
  end
end

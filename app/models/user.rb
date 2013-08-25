class User < ActiveRecord::Base
  include OmniAuthHelper

  acts_as_voter

  acts_as_authentic do |c|
    %w(length format uniqueness).each do |type|
      c.send "merge_validates_#{type}_of_email_field_options", allow_blank: true
    end
  end

  has_many :authentications, dependent: :destroy

  validates :name, presence: true

  def apply_omniauth(omniauth)
    authentication = build_authentication(omniauth)
    populate_from_auth(omniauth, &authentication.dsl)
  end

  def build_authentication(omniauth)
    authentications.build(authentication_attributes(omniauth))
  end

  def create_authentication(omniauth)
    authentications.create(authentication_attributes(omniauth))
  end

  private

  def authentication_attributes(omniauth)
    {
      uid: omniauth.uid, provider: omniauth.provider,
      type: "#{omniauth.provider.classify}Authentication"
    }
  end
end

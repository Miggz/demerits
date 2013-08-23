class User < ActiveRecord::Base
  acts_as_voter
  acts_as_authentic
end

class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :voter, polymorphic: true

  validates :votable_id, :votable_type, :voter_id, :voter_type, presence: true
end

module Voter
  def acts_as_voter
    include InstanceMethods
  end

  module InstanceMethods
    def self.included(base)
      base.class_eval do
        has_many :votes, as: :voter, dependent: :destroy
      end
    end

    def vote(votable, flag: true)
      vote = Vote.find_or_initialize_by voter: self, votable: votable
      vote.value += flag ? 1 : -1
      vote.save
    end
  end
end

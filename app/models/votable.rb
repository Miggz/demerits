module Votable
  def acts_as_votable
    include InstanceMethods
  end

  module InstanceMethods
    def self.included(base)
      base.class_eval do
        has_many :votes, as: :votable, dependent: :destroy
      end
    end

    def vote(voter, flag: true)
      vote = Vote.find_or_initialize_by voter: voter, votable: self
      vote.value += flag ? 1 : -1
      vote.save
    end

    def tally
      Vote.where(votable_id: id, votable_type: self.class.name).sum(:value)
    end
  end
end

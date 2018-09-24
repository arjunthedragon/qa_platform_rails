class Vote < ApplicationRecord
  include Formats::Vote
  include CollectionMethods::Votes


  # => Constants ...
  VOTE_TYPE_UPVOTE = "upvote"
  VOTE_TYPE_DOWNVOTE = "downvote"

  VOTERABLE_TYPE_QUESTION = Question.to_s
  VOTERABLE_TYPE_ANSWER = Answer.to_s

  VOTE_TYPES = [
    VOTE_TYPE_UPVOTE,
    VOTE_TYPE_DOWNVOTE
  ]

  VOTERABLE_TYPES = [
    VOTERABLE_TYPE_QUESTION,
    VOTERABLE_TYPE_ANSWER
  ]
  
  
  # => Relations ...
  belongs_to :voter, class_name: User.to_s
  belongs_to :voterable, polymorphic: true


  # => Validations ...
  validates :vote_type, inclusion: { :in => VOTE_TYPES }
  validates :voterable_type, inclusion: { :in => VOTERABLE_TYPES }
  validates_uniqueness_of :voter_id, scope: %i[vote_type voterable_type voterable_id]

  validate :prevent_self_vote


  # => Scopes ...
  scope :upvoted, -> {
    where(vote_type: VOTE_TYPE_UPVOTE)
  }

  scope :downvoted, -> {
    where(vote_type: VOTE_TYPE_DOWNVOTE)
  }


  # => Callbacks ...
  before_validation :preset_voterable_types

  after_save :remove_opposite_vote_if_exists



  private

  def prevent_self_vote
    # => Code to prevent the user to self vote his or her own answer ...

    if self.voterable.is_a?(Answer) && self.voterable.answered_by_id == self.voter_id
      errors[:User]<<"cannot upvote or downvote his / her own answer "
      return 
    end

    if self.voterable.is_a?(Question) && self.voterable.post.user_id == self.voter_id
      errors[:User]<<"cannot upvote or downvote his / her own Question "
      return 
    end
  end

  def preset_voterable_types
    # => make the first letter of voterable type as capital ...

    self.voterable_type = self.voterable_type.humanize
  end

  def remove_opposite_vote_if_exists
    # => If previously there exists a different vote for this question
    # => We Remove that move that ...

    opposite_vote_type = Vote.opposite_vote_type(self.vote_type)
    previous_vote = Vote
                    .where(voter_id: self.voter_id)
                    .where(voterable_type: self.voterable_type)
                    .where(voterable_id: self.voterable_id)
                    .where(vote_type: opposite_vote_type)
                    .first


    if previous_vote.present?
      # => Remove the previous vote made ...

      previous_vote.destroy!
    end
  end

end
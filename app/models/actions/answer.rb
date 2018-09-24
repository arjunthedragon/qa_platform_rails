module Actions::Answer
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end


module ClassMethods

end

module InstanceMethods

  def mark_acceptance!
    # => updating the acceptance status in answer object by marking the answer as accepted ...

    self.is_accepted = true
    self.save!
  end

  def clear_acceptance!
    # => # => updating the acceptance status in answer object by clearing the answer acceptance ...

    self.is_accepted = false
    self.save!
  end

  def add_feedback!( feedback_type )
    # => We add a feedback instance in the db related to this answer ...

    feedback = self.feedbacks.new
    feedback.feedback_type = feedback_type
    feedback.save!

  end

  def add_comment!(comment_message)
    # => We add comment instance in the db related to this answer ...

    comment = self.comments.new
    comment.description = comment_message
    comment.save!
  end

  def update_answer_net_votes_count!
    # => We update the net votes count using the answer upvotes count and downvotes count ...
    # => This method is to be called whenever an upvote or downvote is done ...

    answer_net_votes_count = self.answer_upvotes.count - self.answer_downvotes.count
    self.update_columns(net_votes_count: answer_net_votes_count)
  end
  
end
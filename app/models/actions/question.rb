module Actions::Question
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end


module ClassMethods

end

module InstanceMethods

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

  def update_question_net_votes_count!
    # => We update the net votes count using the question upvotes count and downvotes count ...
    # => This method is to be called whenever an upvote or dowmvote is done ...

    question_net_votes_count = self.question_upvotes.count - self.question_downvotes.count
    self.update_columns(net_votes_count: question_net_votes_count)
  end
  
end
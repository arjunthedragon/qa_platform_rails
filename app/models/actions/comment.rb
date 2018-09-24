module Actions::Comment
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end


module ClassMethods

end

module InstanceMethods

  def add_feedback!( feedback_type )
    # => We add a feedback instance in the db related to this comment ...

    feedback = self.feedbacks.new
    feedback.feedback_type = feedback_type
    feedback.save!

  end

  def add_comment!(comment_message)
    # => We add comment instance in the db related to this comment ...

    comment = self.comments.new
    comment.description = comment_message
    comment.save!
  end
  
end
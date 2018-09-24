module Formats::Feedback

  def as_json( opts = {} )
    {
      id: self.id,
      feedback_type: self.feedback_type,
      user: self.user.as_json
    }
  end

end
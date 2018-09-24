module Attributes::User
  
  def name
    self.profile.try(:name)
  end

  def points
    # => We dynamically compute the points ...

    question_upvotes_count = self.question_upvotes.count
    answer_upvotes_count = self.answer_upvotes.count

    question_downvotes_count = self.question_downvotes.count
    answer_downvotes_count = self.answer_downvotes.count

    accepted_answers_count = self.accepted_answers.count

    points_received = ( question_upvotes_count * Question::QUESTION_VOTE_VALUE ) + ( answer_upvotes_count * Answer::ANSWER_VOTE_VALUE )
    points_lost = ( question_downvotes_count * Question::QUESTION_VOTE_VALUE) + ( answer_downvotes_count * Answer::ANSWER_VOTE_VALUE )

    points_received += ( accepted_answers_count * Answer::ACCEPTED_ANSWER_VOTE_VALUE )

    net_points = points_received - points_lost
    net_points
  end

end
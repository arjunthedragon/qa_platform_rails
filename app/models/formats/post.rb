module Formats::Post
  
  def as_json(opts = {})
    {
      id: self.id,
      title: self.title,
      question: self.question.as_json,
      answers: self.answers.as_json,
      accepted_answer: self.accepted_answer,
      status: self.status,
      created_at: self.created_at.to_i,
      tags: self.tags,
      post_category: self.post_category,
      favoured_users: self.favoured_users,
      requested_users: self.requested_users,
      question_upvotes_count: self.question_upvotes.count,
      question_downvotes_count: self.question_downvotes.count,
      has_accepted_answer: self.has_accepted_answer? 
    }
  end

end
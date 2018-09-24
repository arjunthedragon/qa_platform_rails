module Formats::Question

  def as_json( opts = {} )
    {
      id: self.id,
      title: self.title,
      description: self.description,
      upvotes: self.question_upvotes.as_json,
      downvotes: self.question_downvotes.as_json,
      net_votes_count: self.net_votes_count,
      edit_suggestions: self.edit_suggestions.as_json,
      post_id: self.post.id,
      comments: self.comments.as_json,
      feedbacks: self.feedbacks.as_json
    }
  end 
  
end

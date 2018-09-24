module Formats::Answer

  def as_json( opts = {} )
    {
      id: self.id,
      description: self.description,
      upvotes: self.answer_upvotes.as_json,
      downvotes: self.answer_downvotes.as_json,
      net_votes_count: self.net_votes_count,
      edit_suggestions: self.edit_suggestions.as_json,
      post_id: self.post.id,
      is_accepted: self.is_accepted?,
      comments: self.comments.as_json,
      feedbacks: self.feedbacks.as_json
    }
  end 
  
end

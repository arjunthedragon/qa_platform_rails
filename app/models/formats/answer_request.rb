module Formats::AnswerRequest

  def as_json( opts = {} )
    {
      id: self.id,
      requested_user: {
        id: self.requested_user.id,
        name: self.requested_user.name,
        points: self.points,
        profile: self.profile.as_json
      },
      post_id: self.post.id
    }
  end 
  
end

module Formats::Vote

  def as_json( opts = {})
    {
      id: self.id,
      vote_type: self.vote_type,
 	  voted_at: self.created_at.to_i
    }
  end

end
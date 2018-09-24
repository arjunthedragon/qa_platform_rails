module Formats::Comment

  def as_json( opts = {})
    {
      id: self.id,
      description: self.description,
      created_at: self.created_at.to_i
    }
  end

end
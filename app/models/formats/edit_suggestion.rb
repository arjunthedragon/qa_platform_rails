module Formats::EditSuggestion 

  def as_json( opts = {} )
    {
      id: self.id,
      title: self.title,
      description: self.description,
      status: self.status
    }
  end

end
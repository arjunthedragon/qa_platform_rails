module Formats::TagWeight

  def as_json( opts = {})
    {
      id: self.tag1.as_json,
      name: self.tag2.as_json,
      weight: self.weight
    }
  end

end
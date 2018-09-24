module Formats::Department

  def as_json( opts = {})
    {
      id: self.id,
      name: self.name
    }
  end

end
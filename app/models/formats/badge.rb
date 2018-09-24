module Formats::Badge

  def as_json( opt = {})
    {
      id: self.id,
      name: self.name
    }
  end
end
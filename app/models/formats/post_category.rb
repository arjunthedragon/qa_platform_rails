module Formats::PostCategory
  
  def as_json( opt = {})
    {
      id: self.id,
      name: self.name,
      description: self.description,
      department: self.department.as_json
    }
  end
  
  
end
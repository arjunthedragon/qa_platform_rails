module Formats::Profile
  def as_json(opts = {})
    {
      id: self.id,
      email: self.user.email,
      first_name: self.first_name,
      last_name: self.last_name,
      dob: {
      	date_of_birth: self.dob,
      	day: self.dob.try(:day),
      	month: self.dob.try(:month),
      	year: self.dob.try(:year)
      },
      image_url: self.image_url
    }
  end
end
module Formats::User 
  def as_json(opts = {})
    {
      id: self.id,
      name: self.name,
      email: self.email,
      profile: self.profile.as_json,
      authentication_token: self.authentication_token,
      phone_number: self.phone_number,
      points: self.points,
      badges: self.badges.as_json
    }
  end

  def session_details
    {
      id: self.id,
      name: self.name,
      email: self.email,
      profile: self.profile.as_json,
      authentication_token: self.authentication_token,
      phone_number: self.phone_number
    }
  end
end
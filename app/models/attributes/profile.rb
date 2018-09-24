module Attributes::Profile
  
  def name=(full_name)
    # => splits name into first_name and last_name ...

    names = full_name.split(' ')
    self.first_name = names.shift
    self.last_name = names.join(' ')
  end

  def name
  	# => returns the first_name and last_name combined ...

    self.first_name + ' ' + self.last_name
  end

  def image_url
  	# => obtains the image_url for the profile ...

  	self.image.try(:attachment_url) 
  end
end
module Formats::Attachment

  def as_json(opts={})
    {
      id: self.id,
      image_url: self.attachment_url
    }
  end

end
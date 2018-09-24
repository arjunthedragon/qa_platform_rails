module Attributes::Attachment

  def s3_credentials
    {
      :bucket => 'point-location', 
      :access_key_id => 'AKIAJL5V52XB5WWUL7BA', 
      :secret_access_key => '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'
    }
  end

  def attachment_url
    self.try(:file).try(:url)
  end

end
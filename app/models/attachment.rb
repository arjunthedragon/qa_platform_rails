class Attachment < ApplicationRecord
  include Formats::Attachment
  include Attributes::Attachment

  # => Relations ...
  has_attached_file :file,
                    :storage => :s3,
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials },
                    :s3_region => 'us-east-1',
                    :s3_permissions => 'public-read',
                    styles: { 
                      original:  "200x200>" 
                    }
  

  do_not_validate_attachment_file_type :file

  belongs_to :attachable, :polymorphic => true

end

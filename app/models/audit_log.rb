class AuditLog < ApplicationRecord

  # => Relations ....
  belongs_to :auditor, polymorphic: true

  
  # => Validations ...
  validates_presence_of :auditor, :event

end

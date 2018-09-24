module ActiveRecordExtension

  extend ActiveSupport::Concern

  
  included do
    include ActiveModel::Validations
    include ActiveModel::Validations::Callbacks

    before_validation :assign_boolean_attributes, :if => :has_class_with_boolean_attributes_instance_vars?
  end
  
  
  # add your instance methods here
  def assign_boolean_attributes
    # => Automatically peforms the conversion of "true" to true for all boolean attributes...

    self.class.boolean_attributes_instance_vars.each do |boolean_attributes_instance_var|
      eval("self.#{boolean_attributes_instance_var} = self.#{boolean_attributes_instance_var}.to_s.to_bool rescue false")
    end
  end

  def has_class_with_boolean_attributes_instance_vars?
    # => checks whether any argument symbols exists for boolean paramters function ...
    
    self.class.boolean_attributes_instance_vars.present?
  end

end

# include the extension 
ActiveRecord::Base.send(:include, ActiveRecordExtension)
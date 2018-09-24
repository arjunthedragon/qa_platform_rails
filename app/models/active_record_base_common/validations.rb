module ActiveRecordBaseCommon::Validations
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  VALID_PHONE_FORMAT = /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/

  class HasOneValidator < ActiveModel::EachValidator
    
    def validate_each(record, attribute, value)
      record_class_sym = record.class.name.downcase.to_sym
      if record.try(attribute.to_sym).nil?
        record.errors.add record_class_sym, "must have one #{attribute} "
      end
    end

  end

  class HasManyValidator < ActiveModel::EachValidator

    def validate_each(record, attribute, value)
      record_class_sym = record.class.name.downcase.to_sym
      if record.try(attribute.to_sym).nil? || record.try(attribute.to_sym).empty?
        record.errors.add record_class_sym,"must have atleast one #{attribute}"
      end
    end
  end


end


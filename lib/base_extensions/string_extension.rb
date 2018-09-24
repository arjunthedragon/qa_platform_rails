module StringExtension

  extend ActiveSupport::Concern

  # add your instance methods here

  def to_bool
    # => convets "true" -> true and "false" to false ...
    
    self.downcase == "true"
  end

end

# include the extension 
String.send(:include, StringExtension)
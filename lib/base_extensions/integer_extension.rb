module IntegerExtension

  extend ActiveSupport::Concern

  # add your instance methods here
  
  def rjust(digits, digit_val)
    self.to_s.rjust(digits, digit_val.to_s)
  end

end

# include the extension 
Integer.send(:include, IntegerExtension)
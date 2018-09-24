module FloatExtension

  extend ActiveSupport::Concern

  # add your instance methods here
  
  def to_rad
    (self.to_f / 180.00) * Math::PI
  end

end

# include the extension 
Float.send(:include, FloatExtension)
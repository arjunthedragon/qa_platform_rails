module ArrayExtension

  extend ActiveSupport::Concern

  # add your instance methods here

  def has_duplicate?
    !(self.count == self.uniq.count)
  end
  
  def average
    arr = self.compact
    avg = ((arr.inject{ |sum, ele| sum + ele }.to_f) / arr.size)
    (avg.nan?) ? nil : avg
  end
  
  def has_any_array_elements?(array)
    (self && array).any?
  end
end

# include the extension 
Array.send(:include, ArrayExtension)
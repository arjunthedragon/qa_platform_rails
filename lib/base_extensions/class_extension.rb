module ClassExtension

  extend ActiveSupport::Concern

  attr_accessor :boolean_attributes_instance_vars

  # add your instance methods here

  def where_by_elements(query_option)
    attribute = query_option.keys.first
    search_elements = query_option[attribute]

    raise "invalid argument" unless (search_elements.is_a?(Array) && query_option.is_a?(Hash))

    query_str = search_elements.map{|ele| "'#{ele}' = ANY(#{attribute.to_s})"}.join(" OR ")
    self.where(query_str)
  end

  def empty
    self.where(id: nil)
  end

  def boolean_attributes(*args, &block)
    # => the boolean arguments are set when the rails server is restarted / started ...
    
    self.boolean_attributes_instance_vars = args
  end


end

# include the extension 
Class.send(:include, ClassExtension)
module CollectionMethods::Tags

  def self.included(receiver)
    receiver.extend     ClassMethods
  end

  module ClassMethods

    def generate_csv_data
      
      lines = []
      
      IO.foreach('Tags.csv') do |line|
        
        lines << line
      
        if lines.size >= 1000
          lines = CSV.parse(lines.join, headers: true) rescue next
        
          lines.each do |row|
            attr_array = row.to_s.split(",")
            id = attr_array[0].to_i
            name = attr_array[1].to_s.chomp

            t = Tag.new(id: id, name: name)
            if t.valid?
              t.save! rescue next
            else
              next
            end

            puts "\n Tag created #{id} and #{name}"
          end

          lines = []
        end
      end
    
    end

  end

end
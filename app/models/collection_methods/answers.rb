module CollectionMethods::Answers

  def self.included(receiver)
    receiver.extend     ClassMethods
  end

  module ClassMethods


    def generate_csv_data
      
      # => id, owner_id, creation_date, parent_id, score, body
      
      lines = []
      
      IO.foreach('Answers.csv') do |line|
        
        lines << line
      
        if lines.size >= 10000
          lines = CSV.parse(lines.join, headers: true) rescue next
        
          lines.each do |row|
            attr_array = row.to_s.split(",")
            id = attr_array[0].to_i
            user_id = attr_array[1].to_s.chomp
            creation_datetime = DateTime.parse(attr_array[2].to_s.chomp) rescue DateTime.now
            post_id = attr_array[3].to_s.chomp.to_i
            body  = attr_array[5].to_s.chomp
            
            answer = Answer.new({
              id: id,
              answered_by_id: user_id.to_i, 
              description: body,
              created_at: creation_datetime,
              post_id: post_id
            })

            if answer.valid? && answer.post.present? && answer.answered_by.present?
              answer.save! rescue next
            else
              next
            end

            puts "\n Answer created #{id} and #{post_id}"
          end

          lines = []
        end
      end
    
    end

  end

end
module CollectionMethods::Users
  
  def self.included(receiver)
    receiver.extend     ClassMethods
  end

  module ClassMethods

    def build_user_by_id(user_id)
      # => This attribute method is mainly for generating a user instance based on the user id passed ...

      first_name = "user" + user_id.to_s
      email = first_name + "@gmail.com"
      last_name = [:tp, :kp, :ak].sample.to_s
      phone_numer = (9000000000 + user_id).to_s
      dob = ((rand() * (30*365*24)) + (10*365*24)).hours.ago

      User.new({
        id: user_id.to_i,
        email: email,
        password: "qwerty123",
        phone_number: phone_numer,
        profile_attributes: {
          first_name: first_name,
          last_name: last_name,
          dob: dob
        }
      })
    end

    def generate_csv_data_from_questions
      
      lines = []
      
      IO.foreach('Questions.csv') do |line|
        
        lines << line
      
        if lines.size >= 1000
          lines = CSV.parse(lines.join, headers: true) rescue next
        
          lines.each do |row|
            attr_array = row.to_s.split(",")
            user_id = attr_array[1].to_s.chomp.to_i
            
            #id, owner_user_id, creation_data, closed_data, score, title, body

            #t = Tag.new(id: id, name: name)
            #if t.valid?
            #  t.save! rescue next
            #else
            #  next
            #end

            user = User.build_user_by_id(user_id)

            user.save! if user.valid? rescue next
            



            puts "\n User created #{user_id}"
          end

          lines = []
        end
      end
    
    end

    def generate_csv_data_from_answers
      
      lines = []
      
      IO.foreach('Answers.csv') do |line|
        
        lines << line
      
        if lines.size >= 1000
          lines = CSV.parse(lines.join, headers: true) rescue next
        
          lines.each do |row|
            attr_array = row.to_s.split(",")
            user_id = attr_array[3].to_s.chomp.to_i
            
            #id, owner_user_id, creation_data, closed_data, score, title, body

            #t = Tag.new(id: id, name: name)
            #if t.valid?
            #  t.save! rescue next
            #else
            #  next
            #end

            user = User.build_user_by_id(user_id)

            user.save! if user.valid? rescue next
            

            puts "\n User created #{user_id}"
          end

          lines = []
        end
      end
    
    end

    def generate_csv
      generate_csv_data_from_questions
      generate_csv_data_from_answers
    end

  end

end
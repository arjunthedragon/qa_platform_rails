module CollectionMethods::Posts

  def self.included(receiver)
    receiver.extend     ClassMethods
  end

  module ClassMethods

    def assign_random_tags
      # => Assigning random tags to posts ...
      # => We will be randomizing the number of tags as well as the tags assigned to it ...

      tag_ids = Tag.all.map(&:id)

      post_updated = 1

      Post.all.each do |p|
        unless p.tags.empty?
          puts "\n Already has tags"
          next
        end

        no_of_tags = [2, 3, 4, 5, 6, 7, 8, 9, 10].sample
        p.tag_ids = tag_ids.sample(no_of_tags)
        
        if p.tag_ids.empty?
          p.save!
        end
        puts "\n Post saved #{post_updated}"
        post_updated = post_updated + 1
      end

    end

    def generate_csv_data
      
      lines = []
      
      IO.foreach('Questions.csv') do |line|
        
        lines << line
      
        if lines.size >= 1000
          lines = CSV.parse(lines.join, headers: true) rescue next
        
          lines.each do |row|
            attr_array = row.to_s.split(",")
            id = attr_array[0].to_i
            user_id = attr_array[1].to_s.chomp
            creation_datetime = DateTime.parse(attr_array[2].to_s.chomp) rescue DateTime.now
            closed_datetime = DateTime.parse(attr_array[3].to_s.chomp) rescue DateTime.now
            #score = attr_array[4].to_i
            title = attr_array[5].to_s.to_s.chomp
            body  = attr_array[6].to_s.chomp

            post_category_id = PostCategory.first.id

            #id, owner_user_id, creation_data, closed_data, score, title, body

            post = Post.new({
              id: id, 
              title: title,
              user_id: user_id.to_i,
              created_at:  creation_datetime,
              post_category_id: post_category_id,
              question_attributes: {
                description: body
              }
            })

            if post.valid? && post.user.present?
              post.save! rescue next
            else
              next
            end

            puts "\n Post created #{id} and #{title}"
          end

          lines = []
        end
      end
    
    end

  end

end
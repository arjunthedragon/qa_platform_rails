module CollectionMethods::Questions

  def self.included(receiver)
    receiver.extend     ClassMethods
  end
end

module ClassMethods

  def assign_random_votes
    # => Assign random votes ...

    all_questions = Question.all
    all_user_ids = User.all.map(&:id)

    all_questions.all.each do |q|

      answers_count = q.answers.count

      if answers_count <= 0 || q.net_votes_count > 0
        next
      end

      question_upvotes_count = 0
      question_downvotes_count = 0

      if(answers_count > 0 && answers_count < 5) 
        question_upvotes_count = [3 , 4,  5, 6, 7, 8, 9, 10].sample
        question_downvotes_count = [1 , 2, 3, 4, 5].sample
      elsif answers_count >= 5
        question_upvotes_count = rand(15) + 2
      end

      question_upvotes_count.times.each do |i|
        question_upvote = q.question_upvotes.new
        question_upvote.voter_id = all_user_ids.sample
        question_upvote.save! rescue next
      end

      question_downvotes_count.times.each do |i|
        question_downvote = q.question_downvotes.new
        question_downvote.voter_id = all_user_ids.sample
        question_downvote.save! rescue next
      end

      q.save!
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
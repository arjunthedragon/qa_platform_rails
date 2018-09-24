module CollectionMethods::Votes
  
  def self.included(receiver)
    receiver.extend         ClassMethods
  end
  
end

module ClassMethods
    
  def opposite_vote_type(vote_type)
    
    if vote_type == Vote::VOTE_TYPE_UPVOTE
      Vote::VOTE_TYPE_DOWNVOTE
    elsif vote_type == Vote::VOTE_TYPE_DOWNVOTE
      Vote::VOTE_TYPE_UPVOTE
    end
  end

  def generate_votes(total_votes_count, user_ids, voterable_type, voterable_id)
    # => We generate votes based on vote count ...

    total_votes_count.times.each do | i |
      new_vote = Vote.new(
        vote_type: Vote::VOTE_TYPE_UPVOTE, 
        voterable_type: voterable_type, 
        voterable_id: voterable_id,
        voter_id: user_ids.sample
      )

      return unless new_vote.valid? && new_vote.voterable.present? && new_vote.voter.present?
      
      new_vote.save!
      
    end

    additional_votes_count = total_votes_count % 20
    

    additional_votes_count.times.each do | i |

      new_upvote = Vote.new(
        vote_type: Vote::VOTE_TYPE_UPVOTE, 
        voterable_type: voterable_type, 
        voterable_id: voterable_id,
        voter_id: user_ids.sample
      )

      new_downvote = Vote.new(
        vote_type: Vote::VOTE_TYPE_DOWNVOTE, 
        voterable_type: voterable_type, 
        voterable_id: voterable_id,
        voter_id: user_ids.sample
      )

      next unless new_upvote.valid? && new_upvote.valid? && new_upvote.voter.present?
      next unless new_downvote.voterable.present? && new_downvote.voterable.present? && new_downvote.voter.present?

      new_upvote.save!
      new_downvote.save!
    end

  end

  def generate_csv_data_from_questions
      
    lines = []

    user_ids = User.all.map(&:id)
      
    IO.foreach('Questions.csv') do |line|
        
      lines << line
      
      if lines.size >= 10000
        lines = CSV.parse(lines.join, headers: true) rescue next
        
        lines.each do |row|
          attr_array = row.to_s.split(",")
          question_id = attr_array[0].to_s.chomp.to_i
          score = attr_array[4].to_s.chomp.to_i
            
          
          generate_votes(score, user_ids, Question.to_s, question_id) rescue next
            



          puts "\n Votes created for question #{question_id} with #{score}"
        end

        lines = []
      end
    end
  
  end

  def generate_csv_data_from_answers
      
    lines = []

    user_ids = User.all.map(&:id)
      
    IO.foreach('Answers.csv') do |line|
        
      lines << line
      
      if lines.size >= 10000
        lines = CSV.parse(lines.join, headers: true) rescue next
        
        lines.each do |row|
          attr_array = row.to_s.split(",")
          answer_id = attr_array[0].to_s.chomp.to_i
          score = attr_array[4].to_s.chomp.to_i
            
          
          generate_votes(score, user_ids, Answer.to_s, answer_id) rescue next
            



          puts "\n Votes created for answer #{answer_id} with #{score}"
        end

        lines = []
      end
    end
  
  end

  def generate_csv_data
    generate_csv_data_from_questions
    generate_csv_data_from_answers
  end



end
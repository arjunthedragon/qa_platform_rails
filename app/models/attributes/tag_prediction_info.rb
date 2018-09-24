module Attributes::TagPredictionInfo

  def questioner_experience_float_value=( value )
    self.questioner_experience = (value * 100.00).to_i
  end

  def questioner_experience_float_value
    (self.questioner_experience.to_f / 100.00) 
  end

  def average_question_length_float_value=( value )
    self.average_question_length = (value * 100.00).to_i
  end

  def average_question_length_float_value
    (self.average_question_length.to_f / 100.00) 
  end

  def centrality_float_value=( value )
    self.centrality = (value * 100.00).to_i
  end

  def centrality_float_value
    (self.centrality.to_f / 100.00) 
  end

  def posts_count_ratio=( value )
    self.posts_count_ratio_cents = (value * 100.00).to_i
  end

  def posts_count_ratio
    (self.posts_count_ratio_cents.to_f / 100.00) 
  end

  def questioner_experience_ratio=( value )
    self.questioner_experience_ratio_cents = (value * 100.00).to_i
  end

  def questioner_experience_ratio
    (self.questioner_experience_ratio_cents.to_f / 100.00) 
  end

  def net_question_votes_ratio=( value )
    self.net_question_votes_ratio_cents = (value * 100.00).to_i
  end

  def net_question_votes_ratio
    (self.net_question_votes_ratio_cents.to_f / 100.00) 
  end

  def average_question_length_ratio=( value )
    self.average_question_length_ratio_cents = (value * 100.00).to_i
  end

  def average_question_length_ratio
    (self.average_question_length_ratio_cents.to_f / 100.00) 
  end

  def centrality_ratio=( value )
    self.centrality_ratio_cents = (value * 100.00).to_i
  end

  def centrality_ratio
    (self.centrality_ratio_cents.to_f / 100.00) 
  end

  def compute_and_set_popularity_value!
    self.popularity_value = ((self.posts_count_ratio * 4.0) * (self.net_question_votes_ratio * 2.0) * (self.centrality_ratio * 2.0) * (self.questioner_experience_ratio * 1.0) * (self.average_question_length_ratio * 1.0)).round 
  end

  def popularity_value_integer
    ( self.popularity_value > 1100 ) ? 1 : 0
  end

end
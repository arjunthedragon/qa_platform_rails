module Actions::Tag
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end

end

module ClassMethods

end

module InstanceMethods

  def generate_tag_prediction_info(prediction_config_data = {})

    total_post_count = prediction_config_data[:posts_count]
    global_questioner_experience = prediction_config_data[:questioner_experience]
    total_question_votes = prediction_config_data[:net_question_votes]
    global_average_question_length = prediction_config_data[:questioner_experience]
    global_centrality_value = prediction_config_data[:centrality_value]

    if self.tag_prediction_info.nil?
      tag_prediction_info = self.build_tag_prediction_info
    else
      tag_prediction_info = self.tag_prediction_info
    end

    posts = self.posts

    posts_count = posts.count
    questioner_experience = posts.map(&:user).uniq.map(&:experience_value).average
    net_question_votes = posts.map(&:question_net_votes_count).sum
    average_question_length = posts.map(&:description).map(&:length).average

    tag_prediction_info.posts_count = posts_count
    tag_prediction_info.questioner_experience = questioner_experience.round
    tag_prediction_info.net_question_votes = net_question_votes
    tag_prediction_info.average_question_length = average_question_length.round

    tag_prediction_info.posts_count_ratio = (posts_count.to_f / total_post_count.to_f) * 10000.00
    tag_prediction_info.questioner_experience_ratio = (questioner_experience.to_f / global_questioner_experience.to_f)
    tag_prediction_info.net_question_votes_ratio = (net_question_votes.to_f / total_question_votes.to_f) * 10000.00
    tag_prediction_info.average_question_length_ratio = (average_question_length.to_f / global_average_question_length.to_f)

    centrality_value = 0.0;
    associated_tags = self.associated_tags.where.not(:id => self.id)

    associated_tags.each do |associated_tag|
      next if self.id == associated_tag.id

      #centrality_value += TagWeight.compute_weight( associated_tag, self)
      centrality_value += (associated_tag.post_ids & self.post_ids).uniq.count
    end

    centrality_value = (centrality_value / associated_tags.count)
    tag_prediction_info.centrality = centrality_value.round
    tag_prediction_info.centrality_ratio = centrality_value.to_f / global_centrality_value.to_f
    
    tag_prediction_info.compute_and_set_popularity_value!
    tag_prediction_info

  end

  def predict_popularity(prediction_config_data = {})
    require 'liblinear'

    global_result_hash = {
      :posts_count=>112329, 
      :questioner_experience=>7.505740409086624, 
      :net_question_votes=>132056, 
      :average_question_length=>180.8488547035939, 
      :centrality_value=>1.0014406677088943
    }

    tag_prediction_info = self.generate_tag_prediction_info(global_result_hash)
    
    model = Liblinear::Model.load(TagPredictionInfo::QA_PREDICT_FILE_NAME)

    result_val = Liblinear.predict(model, [tag_prediction_info.popularity_value / 1000.00])

    message = "unpopular"
    if result_val == 1
      message = "popular"
    end

    message

  end

end
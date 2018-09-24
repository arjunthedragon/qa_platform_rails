
module Actions::Post
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end


module ClassMethods

end

module InstanceMethods

  def set_opened
    self.status = POST_STATUS_OPENED
    self.save!
  end

  def set_closed
    self.status = POST_STATUS_CLOSED
    self.save!
  end

  def set_protected
    self.status = POST_STATUS_PROTECTED
    self.save!
  end

  def set_not_constructive
    self.status = POST_STATUS_NOT_CONSTRUCTIVE
    self.save!
  end

  def set_duplicate
    self.status = POST_STATUS_DUPLICATE
    self.save!
  end

  def accept_answer( answer_id )
    # => We mark the answer accepted for the corresponding answer id for this question ...

    return if self.accepted_answer.present? && self.accepted_answer.id == answer_id
    return if self.answers.map(&:id).include?(answer_id) == false 

    answer_to_be_accepted = self.answers.where(id: answer_id).first

    return if answer_to_be_accepted.nil?

    if self.has_accepted_answer?
      self.answers.each do |answer|
        answer.clear_acceptance!
      end
      #previous_accepted_answer = self.accepted_answer
      #previous_accepted_answer.clear_acceptance!
    end

    answer_to_be_accepted.mark_acceptance!

  end

  def remove_tags!(tag_ids)
    # => We first need to ensure whether the tag ids are valid to be removed ...

    if self.are_tag_ids_valid?(tag_ids)
      TagPost.where(:tag_id => tag_ids).where(:post_id => self.id).destroy_all
    end

  end
  
end
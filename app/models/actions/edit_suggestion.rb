module Actions::EditSuggestion
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end


module ClassMethods

end

module InstanceMethods

  def reopen!
    # => Reopen the suggestion ...

    self.status = EditSuggestion::EDIT_SUGGESTION_STATUS_OPENED
    self.save!
  end

  def accept!
    # => Accept the suggestion ...

    if self.is_question_suggestion?
      question = self.edit_suggestionable
      
      if self.title.present?
        question_post = question.post
        question_post.title = title
        question_post.save!
      end

      if self.description.present?
        question.description = self.description
        question.save!
      end
    
    elsif self.is_answer_suggestion?
      answer = self.edit_suggestionable

      if self.description.present?
        answer.description = description
        answer.save!
      end
    else
      return
    end

    self.status = EditSuggestion::EDIT_SUGGESTION_STATUS_ACCEPTED
    self.save!(validate: false)
  end

  def reject!
    # => Reject the suggestion ...

    self.status = EditSuggestion::EDIT_SUGGESTION_STATUS_REJECTED
    self.save!
  end
  
end
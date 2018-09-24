module Conditions::EditSuggestion

  def is_opened?
    # => returns whether is the suggestion is opened ...

    self.status == EditSuggestion::EDIT_SUGGESTION_STATUS_OPENED
  end
  
  def is_accepted?
    # => returns whether the user accepted the proposed change ...

    self.status == EditSuggestion::EDIT_SUGGESTION_STATUS_ACCEPTED
  end

  def is_rejected?
    # => returns whether the user rejected the proposed change ...

    self.status == EditSuggestion::EDIT_SUGGESTION_STATUS_REJECTED
  end

  def is_question_suggestion?
    # => returns whether this instance is a question suggestion ...

    self.edit_suggestionable.is_a?(Question)
  end

  def is_answer_suggestion?
    # => returns whether this suggestion is an answer suggestion ...

    self.edit_suggestionable.is_a?(Answer)
  end

  
end
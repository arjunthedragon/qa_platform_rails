class EditSuggestion < ApplicationRecord
  include Formats::EditSuggestion
  include Conditions::EditSuggestion
  include Actions::EditSuggestion

  # => Constants ...
  EDIT_SUGGESTION_STATUS_OPENED = "opened"
  EDIT_SUGGESTION_STATUS_ACCEPTED = "accepted"
  EDIT_SUGGESTION_STATUS_REJECTED = "rejected"

  EDIT_SUGGESTION_STATUSES = [
    EDIT_SUGGESTION_STATUS_OPENED,
    EDIT_SUGGESTION_STATUS_ACCEPTED,
    EDIT_SUGGESTION_STATUS_REJECTED
  ]  

  # => Relationships ...
  belongs_to :edit_suggestionable, polymorphic: true

  # => Validations ...
  validates :edit_suggestionable_type, :edit_suggestionable_id, presence: true
  validates :status, inclusion: { :in => EDIT_SUGGESTION_STATUSES }
  validates_uniqueness_of :question_suggester_id, scope: %i[edit_suggestionable_id edit_suggestionable_type], :if => :is_question_suggestion?
  validates_uniqueness_of :answer_suggester_id, scope: %i[edit_suggestionable_id edit_suggestionable_type], :if => :is_answer_suggestion?

  # => Scopes ...
  scope :opened, -> {
    where(status: EDIT_SUGGESTION_STATUS_OPENED)
  }

  scope :accepted, -> {
    where(status: EDIT_SUGGESTION_STATUS_ACCEPTED)
  }

  scope :rejected, -> {
    where(status: EDIT_SUGGESTION_STATUS_REJECTED)
  }

  # => Callbacks ...
  before_validation :ensure_edit_suggestion_not_accepted
  before_validation :ensure_edit_suggestions_exists
  before_validation :validate_custom_input_parameters

  before_validation on: :create do
    # => On creating a fresh edit suggestion, it would be in open state ...

    self.status = EDIT_SUGGESTION_STATUS_OPENED
  end

  private

  def ensure_edit_suggestion_not_accepted
    # => Once an edit is made by the user. Then, the user is not allowed to make changes to the post or answer ...

    if self.is_accepted?
      errors[:edit_suggestion]<< " You can't update the suggestion if you it is already accepted"
      return
    end
  end


  def ensure_edit_suggestions_exists
    # => Here, we need to ensure that any changes are there for the edit suggestion made ...
    
    if self.title.nil? && self.description.nil?
      errors[:edit_suggestion] << " There are no changes mentioned in your suggestion "
      return
    end


    change_suggested = false

    if self.title.present?
      if !self.title.eql?(self.edit_suggestionable.title)
        change_suggested = true
      end
    end

    if change_suggested == false
      if self.description.present?
        if !self.description.eql?(self.edit_suggestionable.description)
          change_suggested = true    
        end  
      end
    end

    if change_suggested == false
      errors[:edit_suggestion] << " There are no changes mentioned in your suggestion "
    end
    
  end


  def validate_custom_input_parameters
    # => Validating from the input parameters that whether that is valid ...
    # => Ex: If suggestionable type is Answer type. Then, the Answer ID should the ID of the answer
    # => which you are suggesting ...

    if self.answer_suggester_id.nil? && self.question_suggester_id.nil?
      errors[:edit_suggestion] << " You need to specify the id of the suggestor "
      return
    end

    if self.answer_suggester_id.present? && !self.edit_suggestionable.is_a?(Answer)
      errors[:edit_suggestion] << " invalid combination of paramaters"
      return
    end

    if self.question_suggester_id.present? && !self.edit_suggestionable.is_a?(Question)
      errors[:edit_suggestion] << " invalid combination of paramaters"
      return
    end
  end

end

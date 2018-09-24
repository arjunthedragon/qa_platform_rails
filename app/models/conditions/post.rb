module Conditions::Post
  
  def is_open?
    self.status == POST_STATUS_OPEN
  end

  def is_closed?
    self.status == POST_STATUS_CLOSED
  end

  def is_protected?
    self.status == POST_STATUS_PROTECTED
  end

  def is_not_constructive?
    self.status == POST_STATUS_NOT_CONSTRUCTIVE
  end

  def is_duplicate?
    self.status == POST_STATUS_DUPLICATE
  end

  def has_accepted_answer?
    self.accepted_answer.present?
  end

  def are_tag_ids_valid?(tag_ids_to_be_tested)
    (tag_ids_to_be_tested - self.tag_ids).empty?
  end

end
module Attributes::Post

  def question_upvotes_count
    # => returns the count of question upvotes made ...

    self.question_upvotes.count
  end

  def question_downvotes_count
  # => returns the count of question downvotes made ...

    self.question_downvotes.count
  end

end
module Attributes::Answer
  
  def answer_upvotes_count
  	# => returns the count of answer upvotes made ...

    self.answer_upvotes.count
  end

  def answer_downvotes_count
	# => returns the count of answer downvotes made ...

    self.answer_downvotes.count
  end
end
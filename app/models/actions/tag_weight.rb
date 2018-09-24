module Actions::TagWeight

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end


module ClassMethods

  def compute_weight( tag1, tag2 )
    # => In this study, we establish a quite simple tag
    # => network, where each node represents a tag and two nodes are
    # => connected if the corresponding tags belong to at least one same
    # => question. The link in this network thus has a weight, defined
    # => as the frequency of co-occurrence of two associated tags in
    # => the same questions ...

    tag1_posts_ids = tag1.post_ids
    tag2_posts_ids = tag2.post_ids

    #common_posts_ids = (posts_ids_1 & posts_ids_2).flat_map { |n| [n]*[post_ids_1.count(n), post_ids_2.count(n)].min }
    common_posts_ids = (tag1_posts_ids & tag2_posts_ids).uniq
    common_posts_ids.count
  end

end

module InstanceMethods

end
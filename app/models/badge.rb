class Badge < ApplicationRecord

  include Formats::Badge
  include Actions::Badge

  # => Constants ...
  # => BADGE_NAME_STUDENT =>   Asked the first question ...
  # => BADGE_NAME_SCHOLAR =>   Asked 10 Questions and Answered 10 Answers ...  
  # => BADGE_NAME_SEEKER =>    Asked >= 10 Questions ...
  # => BADGE_NAME_ACTIVE =>    Answered >= 10 Answers ...
  # => BADGE_NAME_GOOD_QUESTION =>    Question with 10+ upvotes ...
  # => BADGE_NAME_GREAT_QUESTION =>    Question with 20+ votes ...
  # => BADGE_NAME_FAVOURITE_QUESTION => Has question with 10+ favourites ...
  # => BADGE_NAME_GOOD_ANSWER =>    Answer with 10+ votes ...
  # => BADGE_NAME_GREAT_ANSWER => Answer with 20+ votes ...
  # => BADGE_NAME_TEACHER => Has one accepted answer ...
  # => BADGE_NAME_SAVIOUR => Has 10+ accepted answer ...
  # => BADGE_NAME_GEEK  =>   Has 20+ accepted answer ...    
  # => BADGE_NAME_EDITOR => Has 10+ edits accepted ...
  # => BADGE_NAME_REVIEWER => Has 20+ edits accepted ...
  # => BADGE_NAME_COMMENTATOR => Has comment with 5+ votes ...
  # => BADGE_NAME_SUPPORTER => Has made 10+ upvotes ...
  # => BADGE_NAME_CRITIC => Has made 10+ downvotes ...
  # => BADGE_NAME_MARSHAL => Has reported 10+ posts ...
  # => BADGE_NAME_GUIDE => Has made 10+ posts helpful ...



  BADGE_NAME_STUDENT = "student"
  BADGE_NAME_SCHOLAR = "scholar"
  BADGE_NAME_SEEKER = "seeker"
  BADGE_NAME_ACTIVE = "active"
  BADGE_NAME_GOOD_QUESTION = "good_question"
  BADGE_NAME_GREAT_QUESTION = "great_question"
  BADGE_NAME_FAVOURITE_QUESTION = "favourite_question"
  BADGE_NAME_GOOD_ANSWER = "good_answer"
  BADGE_NAME_GREAT_ANSWER = "great_answer"
  BADGE_NAME_TEACHER = "teacher"
  BADGE_NAME_SAVIOUR = "saviour"
  BADGE_NAME_GEEK = "geek"
  BADGE_NAME_EDITOR = "editor"
  BADGE_NAME_REVIEWER = "reviewer"
  BADGE_NAME_COMMENTATOR = "commentator"
  BADGE_NAME_SUPPORTER = "supporter"
  BADGE_NAME_CRITIC = "critic"
  BADGE_NAME_MARSHAL = "marshal"
  BADGE_NAME_GUIDE = "guide"

  BADGE_NAMES = [
    BADGE_NAME_STUDENT,
    BADGE_NAME_SCHOLAR,
    BADGE_NAME_SEEKER,
    BADGE_NAME_ACTIVE,
    BADGE_NAME_GOOD_QUESTION,
    BADGE_NAME_GREAT_QUESTION,
    BADGE_NAME_FAVOURITE_QUESTION,
    BADGE_NAME_GOOD_ANSWER,
    BADGE_NAME_GREAT_ANSWER,
    BADGE_NAME_TEACHER,
    BADGE_NAME_SAVIOUR,
    BADGE_NAME_GEEK,
    BADGE_NAME_EDITOR,
    BADGE_NAME_REVIEWER,
    BADGE_NAME_COMMENTATOR,
    BADGE_NAME_SUPPORTER,
    BADGE_NAME_CRITIC,
    BADGE_NAME_MARSHAL,
    BADGE_NAME_GUIDE
  ]
  
  # => Relations ...
  has_many :user_badges, :dependent => :destroy
  has_many :users, :through => :user_badges

  # => Validations ...
  validates :name, inclusion: { :in => BADGE_NAMES }

  validates_uniqueness_of :name
  
  
end

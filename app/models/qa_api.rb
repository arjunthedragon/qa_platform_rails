class QaApi

  # => This Class is meant to automate API requests from client ...
  # => This is to illustrate how requests are sent to servers ...
  # => It could be used to show the show how far the server can handle multiple requests, concurrent operations ...

  
  EC2_BASE_URL = "http://ec2-13-232-14-215.ap-south-1.compute.amazonaws.com/"


  # => Accessors ...
  attr_reader :conn, :errors

  def initialize
    # => We initialize the connection instance with faraday framework ...
    # => We set the response type with application / json ...
    # => The form data is url encoded and we are using default net adapter using Net::HTTP ...

    @conn = Faraday.new(:url => EC2_BASE_URL) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      faraday.headers['Content-Type'] = 'application/json'
    end 
    @errors = {}
  end

  def post_questions
    # => Function to Automate API Requests to Create posts within the server ...

    all_posts = Post.all

    all_posts.each do |post|

      posted_user = post.user
      posted_user_profile = posted_user.profile

      question_upvotes = post.question_upvotes
      question_downvotes = post.question_downvotes

      tags = post.tags
      answers = post.answers

      answer_upvotes = answers.map(&:answer_upvotes).flatten.uniq
      answer_downvotes = answers.map(&:answer_downvotes).flatten.uniq
      answered_by_users = answers.map(&:answered_by).flatten.uniq

      user_hash = {
        :force_id => posted_user.id,
        :email => posted_user.email,
        :password => "qwerty123",
        :password_confirmation => "qwerty123",
        :profile_attributes => {
          :force_id =>  posted_user_profile.id,
          :first_name => posted_user_profile.first_name,
          :last_name => posted_user_profile.last_name,
          :dob_day => posted_user_profile.try(:dob).try(:day),
          :dob_month => posted_user_profile.try(:dob).try(:month),
          :dob_year => posted_user_profile.try(:dob).try(:year)
        },
        :phone_number => posted_user.phone_number
      }

      payload = {
        :user => user_hash
      }

      response = @conn.post '/users.json', payload.to_json
      puts "\n\n user response -> #{response}"

      answered_by_users.each do |answered_by_user|
        answered_by_user_profile = answered_by_user.profile
        answered_by_user_hash = {
          :force_id => answered_by_user.id,
          :email => answered_by_user.email,
          :password => "qwerty123",
          :password_confirmation => "qwerty123",
          :profile_attributes => {
            :force_id => answered_by_user_profile.id,
            :first_name => answered_by_user_profile.first_name,
            :last_name => answered_by_user_profile.last_name,
            :dob_day => answered_by_user_profile.try(:dob).try(:day),
            :dob_month => answered_by_user_profile.try(:dob).try(:month),
            :dob_year => answered_by_user_profile.try(:dob).try(:year)
          },
          :phone_number => answered_by_user.phone_number
        }

        payload = {
          :user => answered_by_user_hash
        }

        response = @conn.post '/users.json', payload.to_json
        puts "\n\n answered by user response -> #{response}"

      end
    
      tags.each do |tag|
        tag_hash = {
          :force_id => tag.id,
          :name => tag.name,
          :description => tag.description 
        }

        payload = {
          :tag => tag_hash
        }

        response = @conn.post '/tags.json', payload.to_json
        puts "\n\n  tag response -> #{response}"
      end

      post_hash = {
        :force_id => post.id,
        :title => post.title,
        :status => Post::POST_STATUS_OPENED,
        :post_category_id => 1,
        :user_id => posted_user.id,
        :question_attributes => {
          :description => post.description
        },
        :tag_ids => post.tag_ids
      }

      payload = {
        :post => post_hash
      }

      response = @conn.post "/users/#{posted_user.id}/posts.json", payload.to_json
      puts "\n\n post response -> #{response}"

      answers.each do |answer|



        answer_hash = {
          :force_id => answer.id,
          :answered_by_id => answer.answered_by_id,
          :description => answer.description
        }

        payload = {
          :answer => answer_hash
        }

        response = @conn.post "/posts/#{post.id}/answers.json", payload.to_json
        puts "\n\n  answer response -> #{response}"

      end

    end
  end

  def fetch_users
    # => Function to perform API call to fetch users from the server ...

    loop do
      response = @conn.get "/users/1.json"
      response_json_body = JSON.parse(response.body)
      puts "\n\n users fetched -> #{response_json_body}"
      sleep 10
    end
  end

  def fetch_posts
    # => Function to perform API call to fetch posts from the server ...

    loop do
      response = @conn.get "/users/1/posts.json"
      response_json_body = JSON.parse(response.body)
      puts "\n\n posts fetched -> #{response_json_body}"
      sleep 10
    end
  end
 
  def fetch_answers
    # => Function to perform API call to fetch answers from the server ...

    loop do
      response = @conn.get "/posts/1/answers.json"
      response_json_body = JSON.parse(response.body)
      puts "\n\n answers fetched -> #{response_json_body}"
      sleep 10
    end
  end
end
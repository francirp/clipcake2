class Friend < ActiveRecord::Base
  belongs_to :user

  validates :user_id, uniqueness: { scope: :uid}

  def Friend.query_friends(user)

  uid = user.uid
  access_token = user.access_token

  query1request = "SELECT name, uid FROM user WHERE uid IN (SELECT uid1 FROM friend WHERE uid2=#{uid.to_i})"

  options = { :access_token => "#{access_token}" }
    friends_api = Fql.execute({
    :query1 => query1request
    }, options)

  friends_clean_api = friends_api[0]["fql_result_set"]

    @friends = []

    friends_clean_api.each do |friend|
      f = Friend.new
      f.name = friend["name"]
      f.uid = friend["uid"]
      f.user_id = user.id
      f.save
    end
  end

end

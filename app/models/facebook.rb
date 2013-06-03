class Facebook < ActiveRecord::Base

  attr_accessor :access_token, :uid

  def initialize (access_token, uid, user_id)
    @access_token, @uid, @user_id  = access_token, uid, user_id
  end

  def friends
    if not @friends
        @friends = []
        if @access_token
          query1request = "SELECT name, uid FROM user WHERE uid IN (SELECT uid1 FROM friend WHERE uid2=#{uid})"

          options = { :access_token => "#{@access_token}" }
            friends_api = Fql.execute({
            :query1 => query1request
            }, options)

          friends_clean_api = friends_api[0]["fql_result_set"]

          friends_clean_api.sort! do |a,b|
            puts "in facebook sort"
            if a["name"] < b["name"]
              -1
            elsif a["name"] > b["name"]
              1
            else
              0
            end
          end

          friends_clean_api.each do |friend|
            f = {}
            f["name"] = friend["name"]
            f["uid"] = friend["uid"].to_s
            f["id"] = @user_id
            @friends << f
          end
        end
    end

    return @friends
  end

end

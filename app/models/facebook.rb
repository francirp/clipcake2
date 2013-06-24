class Facebook < ActiveRecord::Base
  belongs_to :user
  attr_accessible :email, :uid, :name, :avatar

  def friends
    cache_id = "friends_#{self.user_id}"
    #track_cache_ids(cache_id)
    #Rails.cache.fetch(cache_id) {
      Rails.logger.debug "Facebook::friends getting friends from facebook #{self.oauth_token}"
      @friends = []
      if self.oauth_token
        query1request = "SELECT name, uid FROM user WHERE uid IN (SELECT uid1 FROM friend WHERE uid2=#{self.uid})"

        options = { :access_token => "#{self.oauth_token}" }
          friends_api = Fql.execute({
          :query1 => query1request
          }, options)

        friends_clean_api = friends_api[0]["fql_result_set"]

        friends_clean_api.sort! do |a,b|
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
      @friends
    #}
  end


end

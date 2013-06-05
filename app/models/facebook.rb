class Facebook

  attr_accessor :access_token, :uid, :user_id

  def initialize (access_token, uid, user_id)
    Rails.logger.debug "Facebook: initialize"
    @access_token, @uid, @user_id  = access_token, uid, user_id
    @query_photos_hash = {}
    @query_friends_photos_hash = {}
  end

   #pulls back friendship photos
  def query_photos(friend_id)
    Rails.logger.debug "Facebook: query_photos"
    Rails.cache.fetch("query_photos#{friend_id}_#{user_id}") {
      Rails.logger.debug "Facebook: getting query_photos"
      recipient_id = friend_id
      query1request = "SELECT src_big, caption, object_id, owner, aid, created FROM photo WHERE object_id IN(SELECT object_id FROM photo_tag WHERE subject = #{uid}) AND object_id IN(SELECT object_id FROM photo_tag WHERE subject=#{recipient_id})"
      options = { :access_token => "#{access_token}" }
        photos_api = Fql.execute({
        :query1 => query1request
        }, options)

      photos_clean_api = photos_api[0]["fql_result_set"]

      @photos = []

      photos_clean_api.each do |photo|
        s = Photo.new
        s.source_url = photo["src_big"]
        s.caption = photo["caption"]
        s.fb_object_id = photo["object_id"]
        s.user_id = photo["owner"]
        s.fb_created_date = Date.strptime(photo["created"].to_s,'%s')
        @photos << s
      end
      @final_photos = [@photos, user_id, friend_id]
    }

  end

  def query_friend_photos(friend_id)

    Rails.logger.debug "Facebook: query_friend_photos"
    Rails.cache.fetch("query_friend_photos#{friend_id}_#{user_id}") {
      Rails.logger.debug "Facebook: query_friend_photos - gettin from facebook"
      recipient_id = friend_id
      query1request = "SELECT src_big, caption, object_id, owner, aid, created FROM photo WHERE object_id IN(SELECT object_id FROM photo_tag WHERE subject=#{recipient_id})"

      options = { :access_token => "#{access_token}" }
        photos_api = Fql.execute({
        :query1 => query1request
        }, options)

      photos_clean_api = photos_api[0]["fql_result_set"]

      @friend_photos = []
      photos_clean_api.each do |photo|
        s = Photo.new
        s.source_url = photo["src_big"]
        s.caption = photo["caption"]
        s.fb_object_id = photo["object_id"]
        s.user_id = photo["owner"]
        s.fb_created_date = Date.strptime(photo["created"].to_s,'%s')
        @friend_photos << s
      end
      @final_friend_photos = [@friend_photos, user_id, friend_id]
    }
  end

  #pulls back individual photo selected by user
  def query_photo(obj_id)

    Rails.logger.debug "Facebook: query_photo"
    Rails.cache.fetch("query_photo#{obj_id}") {
      Rails.logger.debug "Facebook: getting query_photo"
      query1request = "SELECT src_big, caption, object_id, owner, aid, created FROM photo WHERE object_id=#{obj_id}"

      options = { :access_token => "#{access_token}" }
        photos_api = Fql.execute({
        :query1 => query1request
        }, options)

      photos_clean_api = photos_api[0]["fql_result_set"]

      @picked_photos = []

      photos_clean_api.each do |photo|
        s = Photo.new
        s.source_url = photo["src_big"]
        s.fb_object_id = photo["object_id"]
        s.user_id = photo["owner"]
        @picked_photos << s
      end

      @picked_photos
    }

  end


  def query_user_photos

    Rails.logger.debug "Facebook: query_user_photos"
    Rails.cache.fetch("query_user_photos#{user_id}") {

      Rails.logger.debug "Facebook: getting query_user_photos"
      query1request = "SELECT src_big, caption, object_id, owner, aid, created FROM photo WHERE object_id IN(SELECT object_id FROM photo_tag WHERE subject=#{uid})"

      options = { :access_token => "#{access_token}" }
        photos_api = Fql.execute({
        :query1 => query1request
        }, options)

      photos_clean_api = photos_api[0]["fql_result_set"]

      @user_photos = []

      photos_clean_api.each do |photo|
        s = Photo.new
        s.source_url = photo["src_big"]
        s.caption = photo["caption"]
        s.fb_object_id = photo["object_id"]
        s.user_id = photo["owner"]
        s.fb_created_date = Date.strptime(photo["created"].to_s,'%s')
        @user_photos << s
      end
      @final_user_photos = [@user_photos, user_id]
    }
  end

  def friends

    Rails.cache.fetch("friends_#{user_id}") {
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
      @friends
    }
  end

end

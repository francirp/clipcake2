class Facebook < ActiveRecord::Base
  belongs_to :user
  attr_accessible :email, :uid, :name, :avatar

  def track_cache_ids(cache_id)
    @user_cache_array = Rails.cache.read("#{user_id}_cache_array")
    if (@user_cache_array)
      if @user_cache_array.include?(cache_id)
        return
      end
    else
      @user_cache_array = []
    end
    @user_cache_array << cache_id
    Rails.cache.write("#{user_id}_cache_array", @user_cache_array)
  end

  def delete_caches
    @user_cache_array = Rails.cache.read("#{user_id}_cache_array")
    if (@user_cache_array)
      @user_cache_array.each do |cache_id|
        Rails.logger.debug "Facebook: delete_caches #{cache_id}"
        Rails.cache.delete(cache_id)
      end
    end
    Rails.cache.delete("#{user_id}_cache_array")
  end

  def force_cache_refresh(time_in_sec = 7200)
    if (ENV['REFRESH_CACHE_AT'])
      time_in_sec = ENV['REFRESH_CACHE_AT'].to_i
    end
    last_refresh = Rails.cache.fetch("last_refresh_#{user_id}")
    if last_refresh
      if (Time.now - last_refresh > time_in_sec)
        Rails.logger.debug "Facebook::force_cache_refresh_after for user: #{user_id}"
        self.delete_caches
        Rails.cache.write("last_refresh_#{user_id}",Time.now)
      end
    else
      Rails.cache.write("last_refresh_#{user_id}",Time.now)
    end
  end

  #pulls back friendship photos
  def query_photos(friend_id)
    # create photo to avoid undefined class/module memcache error
    # (this is not an optimal work around but it will do for now)
    p = Photo.new
    cache_id = "query_photos#{friend_id}_#{user_id}"
    track_cache_ids(cache_id)
    force_cache_refresh
    Rails.cache.fetch(cache_id) {
      Rails.logger.debug "Facebook: getting query_photos"
      recipient_id = friend_id
      query1request = "SELECT src_big, caption, object_id, owner, aid, created FROM photo WHERE object_id IN(SELECT object_id FROM photo_tag WHERE subject = #{uid}) AND object_id IN(SELECT object_id FROM photo_tag WHERE subject=#{recipient_id})"
      options = { :access_token => "#{oauth_token}" }
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
    # create photo to avoid undefined class/module memcache error
    # (this is not an optimal work around but it will do for now)
    p = Photo.new
    cache_id = "query_friend_photos#{friend_id}_#{user_id}"
    track_cache_ids(cache_id)
    force_cache_refresh
    Rails.cache.fetch(cache_id) {
      Rails.logger.debug "Facebook: query_friend_photos - gettin from facebook"
      recipient_id = friend_id
      query1request = "SELECT src_big, caption, object_id, owner, aid, created FROM photo WHERE object_id IN(SELECT object_id FROM photo_tag WHERE subject=#{recipient_id})"

      options = { :access_token => "#{oauth_token}" }
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
    # create photo to avoid undefined class/module memcache error
    # (this is not an optimal work around but it will do for now)
    p = Photo.new
    cache_id = "query_photo#{obj_id}"
    track_cache_ids(cache_id)
    force_cache_refresh
    Rails.cache.fetch(cache_id) {
      Rails.logger.debug "Facebook: getting query_photo"
      query1request = "SELECT src_big, caption, object_id, owner, aid, created FROM photo WHERE object_id=#{obj_id}"

      options = { :access_token => "#{oauth_token}" }
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
    # create photo to avoid undefined class/module memcache error
    # (this is not an optimal work around but it will do for now)
    p = Photo.new
    cache_id = "query_user_photos#{user_id}"
    track_cache_ids(cache_id)
    force_cache_refresh
    Rails.cache.fetch(cache_id) {
      Rails.logger.debug "Facebook: getting query_user_photos"
      query1request = "SELECT src_big, caption, object_id, owner, aid, created FROM photo WHERE object_id IN(SELECT object_id FROM photo_tag WHERE subject=#{uid})"

      options = { :access_token => "#{oauth_token}" }
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

  def delete_friends
    if (Rails.cache.delete("friends_#{user_id}"))
      Rails.logger.debug "Facebook::delete_friends deleted friends cache for user: #{user_id}"
    end
  end

  def friends
    cache_id = "friends_#{user_id}"
    track_cache_ids(cache_id)
    force_cache_refresh
    Rails.cache.fetch(cache_id) {
      Rails.logger.debug "Facebook::friends getting friends from facebook #{oauth_token}"
      @friends = []
      if self.oauth_token
        query1request = "SELECT name, uid FROM user WHERE uid IN (SELECT uid1 FROM friend WHERE uid2=#{uid})"

        options = { :access_token => "#{oauth_token}" }
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
    }
  end


end

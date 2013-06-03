class Facebook

  attr_accessor :access_token, :uid, :user_id

  def initialize (access_token, uid, user_id)
    @access_token, @uid, @user_id  = access_token, uid, user_id
    @query_photos_hash = {}
    @query_friends_photos_hash = {}
  end

   #pulls back friendship photos
  def query_photos(friend_id)

    #if not @query_photos_hash[friend_id]

      recipient_id = friend_id
      query1request = "SELECT src_big, caption, object_id, owner, aid, created FROM photo WHERE object_id IN(SELECT object_id FROM photo_tag WHERE subject = #{uid}) AND object_id IN(SELECT object_id FROM photo_tag WHERE subject=#{recipient_id})"
      puts query1request
      puts access_token
      options = { :access_token => "#{access_token}" }
        photos_api = Fql.execute({
        :query1 => query1request
        }, options)

      photos_clean_api = photos_api[0]["fql_result_set"]

        @photos = []

        puts "photos_clean_api: #{photos_clean_api.count}"

        photos_clean_api.each do |photo|
          s = Photo.new
          s.source_url = photo["src_big"]
          s.caption = photo["caption"]
          s.fb_object_id = photo["object_id"]
          s.user_id = photo["owner"]
          s.fb_created_date = Date.strptime(photo["created"].to_s,'%s')
          @photos << s
          puts s
        end
        puts "Photos:"
        puts @photos
        @final_photos = [@photos, user_id, friend_id]
        puts @final_photos
        @query_photos_hash[friend_id] = @final_photos
    #end

    return @query_photos_hash[friend_id]

  end

  def query_friend_photos(friend_id)

    if not @query_friends_photos_hash[friend_id]
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
          puts s
        end
        @final_friend_photos = [@friend_photos, user_id, friend_id]
        @query_friends_photos_hash[friend_id] = @final_friend_photos
    end

    return @query_friends_photos_hash[friend_id]

  end

end

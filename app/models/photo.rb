class Photo < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  belongs_to :role
  belongs_to :page


  #pulls back friendship photos
  def Photo.query_photos(friend_id, user)


    uid = user.uid
      access_token = user.access_token
      recipient_id = friend_id
      query1request = "SELECT src_big, caption, object_id, owner, aid, created FROM photo WHERE object_id IN(SELECT object_id FROM photo_tag WHERE subject = #{uid}) AND object_id IN(SELECT object_id FROM photo_tag WHERE subject=#{recipient_id})"
logger.debug "Photo.query_photos #{query1request}"
logger.debug "Photo.query_photos #{friend_id} #{access_token}"

    #if @final_photos.present? != true || @final_photos[1] != user.id || @final_photos[2] != friend_id
      uid = user.uid
      access_token = user.access_token
      recipient_id = friend_id
      query1request = "SELECT src_big, caption, object_id, owner, aid, created FROM photo WHERE object_id IN(SELECT object_id FROM photo_tag WHERE subject = #{uid}) AND object_id IN(SELECT object_id FROM photo_tag WHERE subject=#{recipient_id})"

      options = { :access_token => "#{access_token}" }
        photos_api = Fql.execute({
        :query1 => query1request
        }, options)

      photos_clean_api = photos_api[0]["fql_result_set"]

        @photos = []
logger.debug "getting photo"
        photos_clean_api.each do |photo|
          s = Photo.new
          s.source_url = photo["src_big"]
          s.caption = photo["caption"]
          s.fb_object_id = photo["object_id"]
          s.user_id = photo["owner"]
          s.fb_created_date = Date.strptime(photo["created"].to_s,'%s')
          @photos << s
          logger.debug "got photo"
        end
        @final_photos = [@photos, user.id, friend_id]
      return @final_photos
    #else
      #return @final_photos
    #end
  end


  #pulls back individual photo selected by user
  def Photo.query_photo(obj_id, user)

    access_token = user.access_token
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

      return @picked_photos
  end



  def Photo.query_friend_photos(friend_id, user)


    if @final_friend_photos.present? != true || @final_friend_photos[1] != user.id || @final_friend_photos[2] != friend_id
      uid = user.uid
      access_token = user.access_token
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
        @final_friend_photos = [@friend_photos, user.id, friend_id]
      return @final_friend_photos
    else
      return @final_friend_photos
    end
  end

  def Photo.query_user_photos(user)


    if @final_user_photos.present? != true || @final_user_photos[1] != user.id
      uid = user.uid
      access_token = user.access_token
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
        @final_user_photos = [@user_photos, user.id]
      return @final_user_photos
    else
      return @final_user_photos
    end
  end


end

class PhotosController < ApplicationController

  def index
    @photos = Photo.all
  end

  def show
    @photos = current_user.facebook.query_photo(params[:id])
    @photo = @photos[0]
    @oldphoto = params[:oldphoto]
    @position = params[:position]
    @page = Page.find_by_id(params[:page_id])
    @book = Book.find_by_id(params[:book_id])
  end

  def new
    @page = Page.find_by_id(params[:page_id])
    @book = Book.find_by_id(@page.book_id)
    @photo = Photo.new
    @oldphoto = params[:photo_id]
    @position = params[:position]
    @recipient_fb_id = @book.recipient_fb_id
    @fb_photos = current_user.facebook.query_photos(@recipient_fb_id)
    @fb_photos = @fb_photos[0]
    logger.debug "photo controller getting fb photos"
    @friend_photos = current_user.facebook.query_friend_photos(@recipient_fb_id)
    @friend_photos = @friend_photos[0]
    @user_photos = current_user.facebook.query_user_photos
    @user_photos = @user_photos[0]
  end

  def create
    if Photo.find_by_id(params[:oldphoto]).present?
      @photo = Photo.find_by_id(params[:oldphoto])
      @photo.user_id = session[:user_id]
      @photo.book_id = params[:book_id]
      @photo.page_id = params[:page_id]
      @photo.position = params[:position]
      @photo.source_url = params[:source_url]
      @photo.caption = params[:caption]
      @photo.fb_created_date = params[:fb_created_date]
      @photo.fb_object_id = params[:fb_object_id]
      @photo.is_picked = params[:is_picked]
    else
      @photo = Photo.new
      @photo.user_id = session[:user_id]
      @photo.book_id = params[:book_id]
      @photo.page_id = params[:page_id]
      @photo.position = params[:position]
      @photo.source_url = params[:source_url]
      @photo.caption = params[:caption]
      @photo.fb_created_date = params[:fb_created_date]
      @photo.fb_object_id = params[:fb_object_id]
      @photo.is_picked = params[:is_picked]
    end

    if @photo.save
            redirect_to book_url(@photo.book_id)
          else
      render 'new'
    end
  end

  def edit
    @photo = Photo.find_by_id(params[:id])
  end

  def update
    @photo = Photo.find_by_id(params[:id])
    @photo.user_id = params[:user_id]
    @photo.book_id = params[:book_id]
    @photo.page_id = params[:page_id]
    @photo.position = params[:position]
    @photo.source_url = params[:source_url]
    @photo.caption = params[:caption]
    @photo.fb_created_date = params[:fb_created_date]
    @photo.fb_object_id = params[:fb_object_id]
    @photo.is_picked = params[:is_picked]

    if @photo.save
            redirect_to photos_url
          else
      render 'edit'
    end
  end

  def destroy
    @photo = Photo.find_by_id(params[:id])
    @photo.destroy
        redirect_to photos_url
      end
end

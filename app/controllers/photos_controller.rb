class PhotosController < ApplicationController

  def index
    @photos = Photo.all
  end

  def show
    @photos = Photo.query_photo(params[:id],User.find(session[:user_id]))
    @photo = @photos[0]
    @position = params[:position]
    @page = Page.find_by_id(params[:page_id])
    @book = Book.find_by_id(params[:book_id])
  end

  def new
    @page = Page.find_by_id(params[:page_id])
    @book = Book.find_by_id(@page.book_id)
    @photo = Photo.new
    @position = params[:position]
    @recipient_fb_id = @book.recipient_fb_id
    @fb_photos = Photo.query_photos(@recipient_fb_id, current_user)
    @fb_photos = @fb_photos[0]
  end

  def create
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

    if @photo.save
            redirect_to page_url(@photo.page_id)
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

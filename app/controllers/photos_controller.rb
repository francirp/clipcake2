class PhotosController < ApplicationController

  def index
    @photos = Photo.all
  end

  def show
    @photo = Photo.find_by_id(params[:id])
  end

  def new
    @page = Page.find_by_id(params[:page_id])
    @photo = Photo.new
  end

  def create
    @photo = Photo.new
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

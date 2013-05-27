class PagesController < ApplicationController

  def index
    @pages = Page.all
  end

  def show
    @page = Page.find_by_id(params[:id])
  end

  def new
    @page = Page.new
    @book = Book.find_by_id(params[:book_id])
    @layouts = ["layout1", "layout2", "layout6", "layout3", "layout9", "layout4", "layout7", "layout8", "layout5"]
  end

  def create
    @page = Page.new
    @book = Book.find_by_id(params[:book_id])
    @page.position = @book.pages.count + 1
    @page.book_id = params[:book_id]
    @page.user_id = session[:user_id]
    @page.layout = params[:layout]
    @page.background_color = params[:background_color]
    @page.background_image_url = params[:background_image_url]

    if @page.save
            redirect_to @page
          else
      render 'new'
    end
  end

  def edit
    @page = Page.find_by_id(params[:id])
    @book = Book.find_by_id(params[:book_id])
    @layouts = ["layout1", "layout2", "layout6", "layout3", "layout9", "layout4", "layout7", "layout8", "layout5"]
  end

  def update
    @page = Page.find_by_id(params[:id])
    @page.book_id = params[:book_id] unless params[:book_id].blank?
    @page.user_id = params[:user_id] unless params[:user_id].blank?
    @page.layout = params[:layout] unless params[:layout].blank?
    @page.background_color = params[:background_color] unless params[:background_color].blank?
    @page.background_image_url = params[:background_image_url] unless params[:background_image_url].blank?
    @page.position = params[:position] unless params[:position].blank?

    if @page.save
            redirect_to book_url(@page.book.id)
          else
      render 'edit'
    end
  end

  def destroy
    @page = Page.find_by_id(params[:id])
    @page.destroy
        redirect_to book_url(@page.book.id)
    end

  def destroy_position
  @page = Page.find_by_id(params[:id])
  @photos = @page.photos.where(:position => params[:position])
  @texts = @page.texts.where(:position => params[:position])
  @photos.destroy_all
  @texts.destroy_all
      redirect_to book_url(@page.book.id)
  end

end

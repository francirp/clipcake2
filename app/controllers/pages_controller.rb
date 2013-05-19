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
    @layouts = ["layout1", "layout2", "layout3", "layout4"]
  end

  def create
    @page = Page.new
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
  end

  def update
    @page = Page.find_by_id(params[:id])
    @page.book_id = params[:book_id]
    @page.user_id = params[:user_id]
    @page.layout = params[:layout]
    @page.background_color = params[:background_color]
    @page.background_image_url = params[:background_image_url]

    if @page.save
            redirect_to pages_url
          else
      render 'edit'
    end
  end

  def destroy
    @page = Page.find_by_id(params[:id])
    @page.destroy
        redirect_to pages_url
      end
end

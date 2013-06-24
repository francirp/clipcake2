class PagesController < ApplicationController

  def index
    @pages = Page.all
  end

  def show
    @page = Page.find_by_id(params[:id])

    respond_to do |format|
      format.pdf do
          render :pdf => "show",
          :template => 'pages/show.pdf.erb',
          :show_as_html => params[:debug],
          :layout => true,
          :page_height => '8.5in',
          :page_width => '11in',
          :margin => {:top => '1mm',
                      :bottom => '1mm',
                      :left => '4mm',
                      :right => '1mm'}
      end
      format.html
    end
  end

  def new
    @page = Page.new
    @book = Book.find_by_id(params[:book_id])
    @layouts = ["layout1", "layout2", "layout6", "layout3", "layout9", "layout4", "layout7", "layout8", "layout5"]
  end


  def drop_photo
    logger.debug("drop_photo")
    position = params[:position]
    input_target = "inputPhotoTarget-#{position}"
    puts "input target:"
    puts input_target
    new_img_url = params[input_target]

    page = Page.find_by_id(params[:page_id])
    photo = page.photos.where(:position => params[:position]).first
    if (not photo.present?)
      photo = Photo.new
      photo.position = position
      photo.user_id = page.user_id
      photo.book_id = page.book_id
      page.photos << photo
    end

    logger.debug photo
    logger.debug photo.id
    logger.debug photo.page_id
    logger.debug photo.source_url
    logger.debug new_img_url
    photo.source_url = new_img_url
    photo.save

    respond_to do |format|
      format.js {} # nothing to do; photo has already been updated via drag scripting
    end

  end

  def create
    @page = Page.new
    @book = Book.find_by_id(params[:book_id])
    @page.position = @book.pages.count + 1
    @page.book_id = params[:book_id]
    @page.user_id = current_user.id
    @page.layout = params[:layout]
    @page.background_color = params[:background_color]
    @page.background_image_url = params[:background_image_url]

    if @page.save
            redirect_to @page.book
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

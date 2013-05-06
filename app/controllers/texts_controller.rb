class TextsController < ApplicationController

  def index
    @texts = Text.all
  end

  def show
    @text = Text.find_by_id(params[:id])
  end

  def new
    @text = Text.new
  end

  def create
    @text = Text.new
    @text.user_id = params[:user_id]
    @text.book_id = params[:book_id]
    @text.page_id = params[:page_id]
    @text.message = params[:message]
    @text.position = params[:position]
    @text.font_size = params[:font_size]
    @text.font_type = params[:font_type]
    @text.font_color = params[:font_color]
    
    if @text.save
            redirect_to texts_url
          else
      render 'new'
    end
  end

  def edit
    @text = Text.find_by_id(params[:id])
  end

  def update
    @text = Text.find_by_id(params[:id])
    @text.user_id = params[:user_id]
    @text.book_id = params[:book_id]
    @text.page_id = params[:page_id]
    @text.message = params[:message]
    @text.position = params[:position]
    @text.font_size = params[:font_size]
    @text.font_type = params[:font_type]
    @text.font_color = params[:font_color]
    
    if @text.save
            redirect_to texts_url
          else
      render 'edit'
    end
  end

  def destroy
    @text = Text.find_by_id(params[:id])
    @text.destroy
        redirect_to texts_url
      end
end

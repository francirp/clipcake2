class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    @book = Book.find_by_id(params[:id])
  end

  def new
    @friends = Friend.query_friends(current_user)
    @occasions = ["Birthday", "Wedding", "Graduation", "Get Well Soon", "Holiday", "Just to be Awesome!", "Baby Shower", "Engagement", "Going Away", "Military Appreciation", "Encouragement", "Religious Event"]
    @book_sizes = ['6" x 9"', '8.5" x 11"']
    @book = Book.new
  end

  def create
    @book = Book.new
    @book.captain_id = params[:captain_id]
    @book.recipient_fb_id = params[:recipient_fb_id]
    @book.occasion = params[:occasion]
    @book.event_date = params[:event_date]
    @book.reminder_1 = params[:reminder_1]
    @book.reminder_2 = params[:reminder_2]
    @book.final_reminder = params[:final_reminder]
    @book.contribution_deadline = params[:contribution_deadline]
    @book.book_size = params[:book_size]
    @book.invite_message_subject = params[:invite_message_subject]
    @book.invite_message_body = params[:invite_message_body]
    @book.sharing_preference = params[:sharing_preference]
    @book.name = params[:name]

    if @book.save
            redirect_to "#{new_invite_url}?book_id=#{@book.id}"
          else
      render 'new'
    end
  end

  def invite
    @book = Book.find_by_id(params[:book_id])
  end

  def contributor
    @book = Book.find_by_id(params[:book_id])
  end

  def edit
    @book = Book.find_by_id(params[:id])
  end

  def update
    @book = Book.find_by_id(params[:id])
    @book.captain_id = params[:captain_id]
    @book.recipient_fb_id = params[:recipient_fb_id]
    @book.occasion = params[:occasion]
    @book.event_date = params[:event_date]
    @book.reminder_1 = params[:reminder_1]
    @book.reminder_2 = params[:reminder_2]
    @book.final_reminder = params[:final_reminder]
    @book.contribution_deadline = params[:contribution_deadline]
    @book.book_size = params[:book_size]
    @book.invite_message_subject = params[:invite_message_subject]
    @book.invite_message_body = params[:invite_message_body]
    @book.sharing_preference = params[:sharing_preference]

    if @book.save
            redirect_to book_url(@book.id)
          else
      render 'edit'
    end
  end

  def update_invite
    @book = Book.find_by_id(params[:id])
    @book.reminder_1 = params[:reminder_1]
    @book.reminder_2 = params[:reminder_2]
    @book.final_reminder = params[:final_reminder]
    @book.contribution_deadline = params[:contribution_deadline]
    @book.invite_message_subject = params[:invite_message_subject]
    @book.invite_message_body = params[:invite_message_body]
    @book.sharing_preference = params[:sharing_preference]

    if @book.save
            redirect_to "#{new_contributor_url}?book_id=#{@book.id}"
          else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find_by_id(params[:id])
    @book.destroy
        redirect_to books_url
  end
end

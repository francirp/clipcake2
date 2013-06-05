class BooksController < ApplicationController
  # before_filter :authorize_user, :only => [:edit, :update, :destroy]
  def index
    @books = current_user.books
  end

  def show
    @book = Book.find_by_id(params[:id])
    @recipient_fb_id = @book.recipient_fb_id
    @photo_provider = params[:photo_provider]
    @fb_photos = Photo.query_photos(@recipient_fb_id, current_user)
    @fb_photos = @fb_photos[0]
    @fb_photos = Kaminari.paginate_array(@fb_photos).page(params[:page]).per(8)
    @friend_photos = Photo.query_friend_photos(@recipient_fb_id, current_user)
    @friend_photos = @friend_photos[0]
    @friend_photos = Kaminari.paginate_array(@friend_photos).page(params[:page]).per(8)
    @user_photos = Photo.query_user_photos(current_user)
    @user_photos = @user_photos[0]
    @user_photos = Kaminari.paginate_array(@user_photos).page(params[:page]).per(8)
    @pages = @book.pages
    @pages = Kaminari.paginate_array(@pages).page(params[:pagina]).per(1)

    respond_to do |format|
      if params[:photo_provider].blank?
        format.js { render 'page' }
      elsif params[:photo_provider].present?
        format.js
      end
      format.html
    end
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

    @role = @book.roles.build(:role_type => "captain", :user_id => current_user.id)

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

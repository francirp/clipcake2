class RolesController < ApplicationController

  def index
    @roles = Role.all
  end

  def show
    @role = Role.find_by_id(params[:id])
  end

  def new
    @role = Role.new
  end

  def create

    @book = Book.find_by_id(params[:book_id])
    array = params[:friend_id]

    if array.present?
      array.each do |friend|
        if User.where(:uid => friend).present? != true
          @friend = facebook.friends.find { |f| f["uid"] == friend.to_s }
          @user = User.new
          @user.uid = @friend["uid"]
          @user.full_name = @friend["name"]
          @user.avatar = "https://graph.facebook.com/#{friend}/picture?type=large"
          @user.save
        else
          @user = User.find_by_uid(friend)
        end

          @role = Role.new
          @role.book_id = params[:book_id]
          @role.user_id = @user.id
          @role.role_type = "contributor"
          @role.save
      end
      redirect_to book_url(params[:book_id])
    else
      render '/books/contributor'
    end
  end

  def edit
    @role = Role.find_by_id(params[:id])
  end

  def update
    @role = Role.find_by_id(params[:id])
    @role.book_id = params[:book_id]
    @role.user_id = params[:user_id]
    @role.role_type = params[:role_type]

    if @role.save
            redirect_to roles_url
          else
      render 'edit'
    end
  end

  def destroy
    @role = Role.find_by_id(params[:id])
    @role.destroy
        redirect_to roles_url
      end
end

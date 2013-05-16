class FriendsController < ApplicationController

  def index
    @friends = Friend.all
  end

  def show
    @friend = Friend.find_by_id(params[:id])
  end

  def new
    @friend = Friend.new
  end

  def create
    @friend = Friend.new
    @friend.friend.id = params[:friend.id]
    @friend.user_id = params[:user_id]
    @friend.uid = params[:uid]
    
    if @friend.save
            redirect_to friends_url
          else
      render 'new'
    end
  end

  def edit
    @friend = Friend.find_by_id(params[:id])
  end

  def update
    @friend = Friend.find_by_id(params[:id])
    @friend.friend.id = params[:friend.id]
    @friend.user_id = params[:user_id]
    @friend.uid = params[:uid]
    
    if @friend.save
            redirect_to friends_url
          else
      render 'edit'
    end
  end

  def destroy
    @friend = Friend.find_by_id(params[:id])
    @friend.destroy
        redirect_to friends_url
      end
end

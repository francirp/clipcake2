class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.email = params[:email]
    @user.first_name = params[:first_name]
    @user.last_name = params[:last_name]
    @user.password = params[:password]
    @user.billing_address = params[:billing_address]
    @user.billing_city = params[:billing_city]
    @user.billing_state = params[:billing_state]
    @user.billing_phone = params[:billing_phone]
    @user.shipping_address = params[:shipping_address]
    @user.shipping_city = params[:shipping_city]
    @user.shipping_state = params[:shipping_state]
    @user.shipping_phone = params[:shipping_phone]
    @user.access_token = params[:access_token]
    @user.facebook_id = params[:facebook_id]
    @user.is_activated = params[:is_activated]
    @user.full_name = "#{@user.first_name} #{@user.last_name}"

    if @user.save
            redirect_to users_url
          else
      render 'new'
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    @user.email = params[:email]
    @user.first_name = params[:first_name]
    @user.last_name = params[:last_name]
    @user.password = params[:password]
    @user.billing_address = params[:billing_address]
    @user.billing_city = params[:billing_city]
    @user.billing_state = params[:billing_state]
    @user.billing_phone = params[:billing_phone]
    @user.shipping_address = params[:shipping_address]
    @user.shipping_city = params[:shipping_city]
    @user.shipping_state = params[:shipping_state]
    @user.shipping_phone = params[:shipping_phone]
    @user.access_token = params[:access_token]
    @user.facebook_id = params[:facebook_id]
    @user.is_activated = params[:is_activated]

    if @user.save
            redirect_to users_url
          else
      render 'edit'
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
        redirect_to users_url
      end
end

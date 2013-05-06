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
    @role = Role.new
    @role.book_id = params[:book_id]
    @role.user_id = params[:user_id]
    @role.role_type = params[:role_type]
    
    if @role.save
            redirect_to roles_url
          else
      render 'new'
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

class HomePagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:help, :about, :contact, :news, :home]
  
  def home
  end

  def help
  end

  def about
  end

  def contact
  end

  def news
  end


  def show
    if params[:search].present?
      search = params[:search]
      @users = User.where("email LIKE ?", "%#{search}%").page(params[:page]).per(5)
    else 
      @users = User.where("id != ?",current_user.id).order("first_name").page(params[:page]).per(5)
    end
       @pending_users = current_user.pending_invited.pluck(:friend_id)
  end

  def my_friends
     @users = User.all
  end

  def send_friend_request  
    @invite_friend = User.find_by(id: params[:user_id])
    @invite_user = current_user.invite @invite_friend 
    flash[:notice] = "successfully send Friend Request"
    redirect_to all_users_path
  end

  def approve_friend_request
     @invite_users = current_user.pending_invited_by.where("friendships.is_declined = ?", false)
     @params = params[:user_id]
    if params[:user_id].present?
       @send_request_user = User.find_by(id: params[:user_id])
       approve_friend_request = current_user.approve @send_request_user
       flash[:notice] = "Approve Friend Request"
    end
  end


  def de_clined
    @friend = User.find(params[:user_id])
    @invite_users = current_user.send(:find_any_friendship_with, @friend)
     if @invite_users
        @invite_users.update_attributes(is_declined: true)
        redirect_to all_users_path, :notice => "You Request is Declined"
     end
  end
end

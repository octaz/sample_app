class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :not_needed, only: [:new, :create]
  ##  before_action :no_suicide, only: :destroy




  def index
    @users = User.paginate(page: params[:page])
  end

  def new
  	@user=User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def edit
 #   @user = User.find(params[:id]) with current_user method, this can be omitted
  end

  def create
  	@user = User.new(user_params)   #the final implementation!
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def update
  #  @user = User.find(params[:id]) with current_user method
    if @user.update_attributes(user_params)
     flash[:success] = "Profile Updated"
     redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if (current_user == user && current_user.admin?)
      flash[:danger] = "Cannot Delete Yourself!"
      redirect_to root_url
    else
      user.destroy
      flash[:success] = "User deleted"
      redirect_to users_url
    end
    
  end


  private 

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    def signed_in_user
      if !signed_in?
        store_location
        flash[:warning] = "please sign in"
        redirect_to signin_url
      end
     # redirect_to signin_url, warning: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def not_needed
      redirect_to(root_url) unless !signed_in?
    end

end

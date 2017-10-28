class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :manager, only: [:new, :create, :destroy]

    def user_params
      params.permit(:username, :password, :email)
    end

    def manager
        if current_user.manage == "f"
            flash[:notice] = "You do not have the appropriate privileges to view this page"
            redirect_to user_path current_user
        end
    end

    def index
        if user_signed_in?
            redirect_to user_path current_user
        end
    end

    def show
    end

    def new
    end

    def create
    end

    def edit
    end

    def update
    end

    def destroy
    end

end

class SessionsController < ApplicationController
    def new
    end
    def create
        @user = User.find_by_email params[:email]  #=> [first_name, last_name, email, password_digest]
        if  @user && @user.authenticate(params[:password])
            #or @user&.authenticate = 
            session[:user_id]=@user.id
            redirect_to home_path, notice: 'Logged in'
        else
            flash[:alert]= 'Wrong email or password.'
            render :new
        end

    end
    def destroy
        session[:user_id]=nil
        redirect_to root_path, notice: 'Logged Out!'
    end

end

=begin

user&.authenticate

user && user.authenticate

answer.user&.full_name
answer.user && answer.user.full_name

answer.&.user&.full_name
answer && answer.user && answer.user.full_name

=end
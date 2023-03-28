class SessionsController < ApplicationController

    def create 
    logged_user = User.find_by(username:params[:username])
    if logged_user&.authenticate(params[:password])
    session[:user_id] = logged_user[:id]
    render json: {id:logged_user[:id],username:logged_user[:username],image_url:logged_user[:image_url],bio:logged_user[:bio]}, status: :ok
     else
     render json: {errors:["Not authorized"]}, status:401
     end
     end

    def destroy
        begin
        logged_out_user = User.find(session[:user_id])
        session.delete(:user_id)
        head:no_content
        rescue ActiveRecord::RecordNotFound => e
        render json:{errors:[e]},status:401
        end
    end

end
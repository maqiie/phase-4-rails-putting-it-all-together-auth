class UsersController < ApplicationController
    #rescue_from ActiveRecord::RecordInvalid with: :error_messages
      def create
           # if allowed_params[:password] == allowed_params[:password_confirmation]
            new_user = User.create!(allowed_params)
            session[:user_id] = new_user[:id]
            render json: new_user, status:201
      rescue ActiveRecord::RecordInvalid => e
            render json: {errors:e.record.errors.full_messages}, status:422
            #else
            #render json: {error:"Unprocessble Entity"}, status:422
            #end
        end
    
        def show
         if session[:user_id]
          logged_user = User.find_by(id:session[:user_id])
          render json: logged_user,status:201
         else
        # rescue ActiveRecord::RecordNotFound => e
          render json: {errors:"Unauthorized"}, status:401
         end
        end
    
      private
    
      def allowed_params
        params.permit(:username, :image_url, :bio, :password, :password_confirmation)
      end
    
      # def find_by_id
      #   User.find(params[:id])
      # end
    
      # def error_messages
      #   render json: {error: }
      # end
    end
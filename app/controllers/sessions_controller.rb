class SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by({"email" => params["email"]})
        if @user 
            if BCrypt::Password.new(@user["password"]) == params["password"]
                session["user_id"] = @user["id"]
            flash["notice"] = "You logged in!"
                redirect_to "/companies"    
            else
            flash["notice"] = "Access Denied."
                redirect_to "/sessions/new"    
            end
        else
            flash["notice"] = "Access Denied."
            redirect_to "/sessions/new"
        end
    end

    def destroy 
        session["user_id"] = nil
        flash["notice"] = "Goodbye."
        redirect_to "/sessions/new"
    end
end



class SessionsController < ApplicationController
  def new
  end

  def create
    # authenticate the user
    @user = User.find_by({ "email" => params["email"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome, #{@user["username"]}."
        redirect_to "/places"
      else
        flash["notice"] = "Invalid credentials."
        redirect_to "/login"
      end
    else
      flash["notice"] = "Invalid credentials."
      redirect_to "/login"
    end
  end


  def destroy
    flash["notice"] = "You've logged out, goodbye!"
    session["user_id"] = nil
    redirect_to "/login"
  end
end
  
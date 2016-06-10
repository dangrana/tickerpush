class MessagesController < ApplicationController
  def mail
    # @user = User.find(params[:id])
    @user = current_user
    MyMailer.welcome_email(@user).deliver
    redirect_to "/users", :notice => "Hi "+@user.email
  end
end

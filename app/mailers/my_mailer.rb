class MyMailer < ActionMailer::Base
  default from: ENV["gmail_user_name"]

  # def welcome_email(userid)
  def welcome_email(user)
    # @user = User.find(1)
    @user = user
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def tickpush(user,darray)
    @user = user
    @darray = darray
    mail(to: @user.email, subject: 'Tickerpush: '+@darray[0]+' '+@darray[1])

  end

end

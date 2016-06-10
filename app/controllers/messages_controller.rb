class MessagesController < ApplicationController

  def mail
    @user = User.find(params[:id])


    url="http://finance.google.com/finance/info?client=ig&q="+(@user.ticka || "")+","+(@user.tickb || "")+","+(@user.tickc || "")

    require 'open-uri'
    raw_data=open(url).read

    exnl = raw_data.gsub(/[\n]+/,' ')
    exq = exnl.gsub(/[\"]+/,' ')
    excomm = exq.gsub(/[,]+/,' ')
    exsemi = excomm.gsub(/[:]+/,' ')
    exspace = exsemi.gsub(/[ ]+/,' ')

    bigquotearray = exspace.split("{")
    quotearray = bigquotearray.from(1)


    @darray = []
    quotearray.each do |i|

      startcp = i.match(/t.*/)[0]
      capturenum = startcp[2..5]
      @darray.push(capturenum)

      startcp = i.match(/cp_fix.*/)[0]
      capturenum = startcp[7..15]
      dret = capturenum.gsub(/[^0-9.-]/i, '')
      @darray.push(dret)

      tradedate = i.match(/[[:digit:]][[:digit:]][[:digit:]][[:digit:]]-[[:digit:]][[:digit:]]-[[:digit:]][[:digit:]]/)[0]
      @darray.push(tradedate)

      # time = i.match(/[[:digit:]][[:digit:]][[:digit:]][[:digit:]]-[[:digit:]][[:digit:]]-[[:digit:]][[:digit:]]/)[0]
      # @darray.push(tradetime)

    end


    # MyMailer.welcome_email(@user).deliver
    MyMailer.tickpush(@user,@darray).deliver
    redirect_to "/", :notice => "Update sent, "+@user.email
  end
end

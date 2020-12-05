class HomeController < ApplicationController
  def index
    @entries = Entry.select("strftime('%m/%d/%Y',created_at) as entry_date, count(*) as count").where("user_id = ?", @current_user.id).group("date(created_at)")
    @entry = Entry.new

    @count = @entries.length

  end

  def daily
    @dateString = params[:month] + "/" + params[:day] + "/" + params[:year]
    @entries = Entry.where("user_id = ? and strftime('%m/%d/%Y',created_at) = ?", @current_user.id, @dateString)
    @entry = Entry.new
    @count = @entries.length
  end
end

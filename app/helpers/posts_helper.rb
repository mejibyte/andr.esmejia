module PostsHelper
  def format_date(date)
    date.strftime("%b <br /> %d")
  end
end

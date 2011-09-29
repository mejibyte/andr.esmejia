module PostsHelper
  def format_date(date)
    date.strftime("%b <br /> %d").html_safe
  end
end

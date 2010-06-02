require 'mysql'
require 'pp'

mysql = Mysql.init()
mysql.connect('localhost', 'root', '')
mysql.select_db('andr_wordpress')

Post.destroy_all

results = mysql.query("SELECT * from wp_posts WHERE post_status = 'publish' AND post_type = 'post'")
results.each_hash do |old_post|
  old_post.symbolize_keys!

  post = Post.new
  post.title = old_post[:post_title]
  post.body = old_post[:post_content]
  post.created_at = Time.parse old_post[:post_date]
  
  # now let's get this dude's comment
  comment_results = mysql.query("SELECT * from wp_comments WHERE comment_post_ID = #{old_post[:ID]} AND comment_approved = 1 AND comment_type != 'pingback'")
  comment_results.each_hash do |old_comment|
    old_comment.symbolize_keys!
    
    #pp old_comment
    comment = post.comments.build
    comment.name = old_comment[:comment_author]
    comment.email = old_comment[:comment_author_email]
    comment.ip = old_comment[:comment_author_IP]
    comment.url = old_comment[:comment_author_url]
    comment.body = old_comment[:comment_content]
    comment.created_at = Time.parse old_comment[:comment_date]
  end

  puts "Post '#{post.title}' (#{post.comments.size} comments)"
  post.save!
end

mysql.close()
require "coderay"

module PurpleCloth
  def highlight(opts)
    opts.reverse_merge!(:class => :rb)    
    %(<code class="prettyprint html-#{opts[:class]}">#{opts[:text]}</code>)
  end
end
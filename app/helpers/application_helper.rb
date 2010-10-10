# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def button(options = {})
    content_tag(:li, :id => options[:id]) do
      link_to(options[:text], options[:url], :class => options[:pressed] ? "pressed" : "not-pressed")
    end
  end
  
  def textile_to_html(textile)
     RedclothCoderay.coderay_options :line_numbers => :table
     cloth = RedCloth.new(textile)
     #cloth.extend PurpleCloth
     cloth.to_html
  end
  
  def clear
    "<div class='clear'></div>"
  end
  
  def contact_me_url
    "&#109;&#97;&#105;&#108;&#116;&#111;&#58;%61%6e%64%72@%65%73%6d%65%6a%69%61.%63%6f%6d?" + 
    "subject=" + CGI::escape("Hi, I just clicked on the Contact button on http://andr.esmejia.com.").gsub("+", "%20") +
    "&body=" + CGI::escape("And I wanted to tell you that...").gsub("+", "%20")
  end
end

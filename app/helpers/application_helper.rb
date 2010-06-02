# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def button(options = {})
    content_tag(:li, :id => options[:id]) do
      link_to(options[:text], options[:url], :class => options[:pressed] ? "pressed" : "not-pressed")
    end
  end
  
  def textile_to_html(textile)
     cloth = RedCloth.new(textile)
     cloth.extend PurpleCloth
     cloth.to_html
  end
  
  def clear
    "<div class='clear'></div>"
  end
end

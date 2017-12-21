require 'open-uri'

class HtmlMan

  def self.get(url)
    html = open(url) do |f|
      f.read
    end
    return html
  end

end

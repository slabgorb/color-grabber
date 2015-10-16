require 'open-uri'
require 'nokogiri'

class KulerExport

  def initialize(slug)
    @slug = slug
  end

  def find_colors(doc)
    doc.css('.themeBox li').map do |li|
      li.attr('title')
    end
  end

  def doc
    Nokogiri::HTML(open("https://color.adobe.com/#{@slug}"))
  end

  def to_sass(colors)
    colors.each_with_index.map { |color, i| "$#{@slug}_#{i}: #{color}" }.join("\n")
  end

end

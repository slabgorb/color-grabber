require 'open-uri'
require 'nokogiri'
require 'watir'
require 'color'

class ColorGrabber
  attr_reader :colors

  def initialize(slug, verbose: false)
    @verbose = verbose
    @slug = slug
    @doc = open_doc
    @colors = find_colors
    sort_colors
    upcase
    puts "Verbose mode: doc length: #{@doc.to_s.length}" if @verbose
  end

  def name
    @slug
  end

  def upcase
    @colors.map!{|c| c.upcase }
  end

  def sort_colors
    @colors.sort! {|a,b| Color::RGB.by_hex(a).brightness <=> Color::RGB.by_hex(b).brightness }
  end

  def open_doc
    puts "opening #{url}" if @verbose
    browser = Watir::Browser.start url
    doc = Nokogiri::HTML(browser.html)
    browser.close
    doc
  end

  def to_s
    @colors.join("\n")
  end

  def to_sass
    @colors.each_with_index.map { |color, i| "$#{name_to_scss}_#{i + 1}: #{color};" }.join("\n")
  end

  protected
  def name_to_scss
    name.gsub(/-color-theme-[0-9]+/,'').gsub('-','_').downcase
  end

end


class ColourLovers < ColorGrabber
  def url
    "http://www.colourlovers.com/palette/#{@slug}"
  end
  def find_colors
    @doc.css('a.color').map { |a| "#" << a.attr('href').split('/')[1] }
  end
end


class ColorHex < ColorGrabber
  def url
    "http://www.color-hex.com/color-palette/#{@slug}"
  end
  def find_colors
    @doc.css('.palettecolordivc').map { |a| a.attr('title') }
  end
  def name
    @doc.css('#breadcrumb div em').inner_text()
  end
end

class DesignSeeds < ColorGrabber
  def url
    "http://design-seeds.com/home/entry/#{@slug}"
  end
  def find_colors
    @doc.css('.similar a').map { |a| "#" << a.attr('data-color') }
  end
end

class Kuler < ColorGrabber
  def url
    "https://color.adobe.com/#{@slug}"
  end
  def find_colors
    @doc.css('.themeBox li').map { |li| li.attr('title') }
  end
end

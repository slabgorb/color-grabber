require 'open-uri'
require 'nokogiri'
require 'watir'
require 'color'

class GolorGrabber
  attr_reader :colors

  def initialize(slug, verbose: false)
    @verbose = verbose
    @slug = slug
    @doc = doc ? doc : open_doc
    @colors = find_colors
    sort_colors
    puts "Verbose mode: doc length: #{@doc.to_s.length}" if @verbose
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
    @colors.each_with_index.map { |color, i| "$#{slug_to_scss}_#{i + 1}: #{color};" }.join("\n")
  end

  protected
  def slug_to_scss
    @slug.gsub(/-color-theme-[0-9]+/,'').gsub('-','_').downcase
  end

end

class ColorGrabberDecorator < SimpleDelegator
  def initialize(color_grabber)
    @color_grabber = color_grabber
    super
  end
end

class DesignSeeds < ColorGrabberDecorator
  def url
    "http://design-seeds.com/home/entry/#{@slug}"
  end
  def find_colors
    @doc.css('.similar a').map { |a| a.attr('data-color') }
  end
end

class Kuler < ColorGrabberDecorator
  def url
    "https://color.adobe.com/#{@slug}"
  end
  def find_colors
    @doc.css('.themeBox li').map { |li| li.attr('title') }
  end
end

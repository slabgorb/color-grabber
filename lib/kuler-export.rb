require 'open-uri'
require 'nokogiri'
require 'watir'
require 'headless'

class KulerExport

  attr_reader :colors

  def initialize(slug, doc = nil, verbose: false)
    @verbose = verbose
    @slug = slug
    @doc = doc ? doc : open_doc
    @colors = find_colors
    puts "Verbose mode: doc length: #{@doc.to_s.length}" if @verbose
  end

  def find_colors
    @doc.css('.themeBox li').map { |li| li.attr('title') }
  end

  def open_doc
    url = "https://color.adobe.com/#{@slug}"
    puts "opening #{url}" if @verbose
    # headless = Headless.new
    # headless.start
    browser = Watir::Browser.start url
    doc = Nokogiri::HTML(browser.html)
    browser.close
    doc
  end

  def to_s
    @colors.join("\n")
  end

  def to_sass
    @colors.each_with_index.map { |color, i| "$#{@slug}_#{i}: #{color}" }.join("\n")
  end

end

require 'helper'
require 'nokogiri'

class TestKulerExport < Test::Unit::TestCase

  def test_find_colors
    ke = KulerExport.new('foo')
    colors = ke.find_colors(Nokogiri::HTML(open('test/example.html')))
    assert_equal(["#292929", "#5B7876", "#8F9E8B", "#F2E6B6", "#412A22"], colors)
    assert_equal("$foo_0: #292929\n$foo_1: #5B7876\n$foo_2: #8F9E8B\n$foo_3: #F2E6B6\n$foo_4: #412A22", ke.to_sass(colors))
  end
end

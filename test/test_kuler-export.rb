require 'helper'
require 'nokogiri'

class TestKulerExport < Test::Unit::TestCase

  def test_find_colors
    ke = KulerExport.new('foo', Nokogiri::HTML(open('test/example.html')))
    assert_equal(["#292929", "#412A22", "#5B7876", "#8F9E8B", "#F2E6B6"], ke.colors)
    assert_equal("$foo_1: #292929;\n$foo_2: #412A22;\n$foo_3: #5B7876;\n$foo_4: #8F9E8B;\n$foo_5: #F2E6B6;", ke.to_sass)
    assert_equal("#292929\n#412A22\n#5B7876\n#8F9E8B\n#F2E6B6", ke.to_s)
  end
end

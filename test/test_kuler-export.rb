require 'helper'
require 'nokogiri'

class TestKulerExport < Test::Unit::TestCase

  def test_find_colors
    ke = KulerExport.new('foo', Nokogiri::HTML(open('test/example.html')))
    assert_equal(["#292929", "#5B7876", "#8F9E8B", "#F2E6B6", "#412A22"], ke.colors)
    assert_equal("$foo_1: #292929\n$foo_2: #5B7876\n$foo_3: #8F9E8B\n$foo_4: #F2E6B6\n$foo_5: #412A22", ke.to_sass)
    assert_equal("#292929\n#5B7876\n#8F9E8B\n#F2E6B6\n#412A22", ke.to_s)
  end
end

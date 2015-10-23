require 'helper'
require 'nokogiri'

class TestDesignSeeds < Test::Unit::TestCase

  def test_find_colors
    ke = ColorGrabber::DesignSeeds.new('perched-tones')
    assert_equal(["#383C42", "#5E5554", "#857874", "#A7B5B2", "#BFAFA0", "#D4BFBA"], ke.colors)
    assert_equal("$perched_tones_1: #383C42;\n$perched_tones_2: #5E5554;\n$perched_tones_3: #857874;\n$perched_tones_4: #A7B5B2;\n$perched_tones_5: #BFAFA0;\n$perched_tones_6: #D4BFBA;", ke.to_sass)
    assert_equal("#383C42\n#5E5554\n#857874\n#A7B5B2\n#BFAFA0\n#D4BFBA", ke.to_s)
  end
end

# class TestColourLovers < Test::Unit::TestCase
#   def test_find_colors
#     ke = ColorGrabber::ColourLovers.new('3908330/Dimi')
#     assert_equal(["#383C42", "#5E5554", "#857874", "#A7B5B2", "#BFAFA0", "#D4BFBA"], ke.colors)
#     assert_equal("$perched_tones_1: #383C42;\n$perched_tones_2: #5E5554;\n$perched_tones_3: #857874;\n$perched_tones_4: #A7B5B2;\n$perched_tones_5: #BFAFA0;\n$perched_tones_6: #D4BFBA;", ke.to_sass)
#     assert_equal("#383C42\n#5E5554\n#857874\n#A7B5B2\n#BFAFA0\n#D4BFBA", ke.to_s)
#   end
# end

class TestColorHex < Test::Unit::TestCase
  def test_find_colors
    ke = ColorGrabber::ColorHex.new('389')
    assert_equal(["#3C2F2F", "#4B3832", "#854442", "#BE9B7B", "#FFF4E6"], ke.colors)
    assert_equal("$cappuccino_1: #3C2F2F;\n$cappuccino_2: #4B3832;\n$cappuccino_3: #854442;\n$cappuccino_4: #BE9B7B;\n$cappuccino_5: #FFF4E6;", ke.to_sass)
    assert_equal("#3C2F2F\n#4B3832\n#854442\n#BE9B7B\n#FFF4E6", ke.to_s)
  end
end

class TestKuler < Test::Unit::TestCase

  def test_find_colors
    ke = ColorGrabber::Kuler.new('Metal-color-theme-287290')
    assert_equal(["#00060D", "#203140", "#707F8C", "#A3B2BF", "#F2F2F2"], ke.colors)
    assert_equal("$metal_1: #00060D;\n$metal_2: #203140;\n$metal_3: #707F8C;\n$metal_4: #A3B2BF;\n$metal_5: #F2F2F2;", ke.to_sass)
    assert_equal("#00060D\n#203140\n#707F8C\n#A3B2BF\n#F2F2F2", ke.to_s)
  end
end

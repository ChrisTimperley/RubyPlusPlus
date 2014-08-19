# encoding: utf-8
require 'test/unit'
require '../lib/ruby_plus_plus'
require '../lib/transformers/keyword_transformer'

class KeywordTransformerTest < Test::Unit::TestCase

  def setup
    @transformer = RubyPlusPlus::KeywordTransformer.new
  end

  def test_elsif
    input = "
if (x == 3)
  a = 10 * 60
elsif (x + 10) < (x ** 5)
  a = 3 * 2
end
"
    output = "
if (x == 3)
  a = 10 * 60
else if (x + 10) < (x ** 5)
  a = 3 * 2
end
"
    assert_equal(@transformer.transform_elsif(input), output)
  end

  def test_unless
    input = "
unless (x + 10) < (x ** 5)
  a = 10 * 60
end
"
    output = "
if (!((x + 10) < (x ** 5)))
  a = 10 * 60
end
"
    assert_equal(@transformer.transform_until_and_unless(input), output)
  end

  def test_until
    input = "
until (x + 10) < (x ** 5)
  a = 10 * 60
end
"
    output = "
while (!((x + 10) < (x ** 5)))
  a = 10 * 60
end
"
    assert_equal(@transformer.transform_until_and_unless(input), output)
  end

end

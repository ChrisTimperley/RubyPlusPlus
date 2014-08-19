# encoding: utf-8
require 'test/unit'
require '../lib/ruby_plus_plus'
require '../lib/transformers/condition_transformer'

class ConditionTransformerTest < Test::Unit::TestCase

  def setup
    @transformer = RubyPlusPlus::ConditionTransformer.new
  end

  def test_if_statement
    input = "
x = 20
if (x ** 2) == (3 * x + (y * y))
y = 4
end
"
    output = "
x = 20
if ((x ** 2) == (3 * x + (y * y)))
y = 4
end
"
    assert_equal(output, @transformer.transform(input))
    assert_equal(output, @transformer.transform(output))
  end

  def test_unless_statement
    input = "
x = 20
unless (x ** 2) == (3 * x + (y * y))
y = 4
end
"
    output = "
x = 20
unless ((x ** 2) == (3 * x + (y * y)))
y = 4
end
"
    assert_equal(output, @transformer.transform(input))
    assert_equal(output, @transformer.transform(output))
  end

  def test_if_elsif_statement
    input = "
x = 20
if (x ** 2) == (3 * x + (y * y))
y = 4
elsif z != 5
y = 3
end
"
    output = "
x = 20
if ((x ** 2) == (3 * x + (y * y)))
y = 4
elsif (z != 5)
y = 3
end
"
    assert_equal(output, @transformer.transform(input))
    assert_equal(output, @transformer.transform(output))
  end

  def test_if_else_if_statement
    input = "
x = 20
if (x ** 2) == (3 * x + (y * y))
y = 4
else if z > (5**2)
y = 3
end
"
    output = "
x = 20
if ((x ** 2) == (3 * x + (y * y)))
y = 4
else if (z > (5**2))
y = 3
end
"
    assert_equal(output, @transformer.transform(input))
    assert_equal(output, @transformer.transform(output))
  end

  def test_while_statement
    input = "
while (x * 2) > 10**3
y = 3
end
"
    output = "
while ((x * 2) > 10**3)
y = 3
end
"
    assert_equal(output, @transformer.transform(input))
    assert_equal(output, @transformer.transform(output))
  end

  def test_until_statement
    input = "
until (x * 2) > 10**3
y = 3
end
"
    output = "
until ((x * 2) > 10**3)
y = 3
end
"
    assert_equal(output, @transformer.transform(input))
    assert_equal(output, @transformer.transform(output))
  end

  def test_for_statement
    input = "
for i in collection
y = 3
end
"
    output = "
for (i in collection)
y = 3
end
"
    assert_equal(output, @transformer.transform(input))
    assert_equal(output, @transformer.transform(output))
  end

end

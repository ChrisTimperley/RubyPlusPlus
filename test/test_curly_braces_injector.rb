# encoding: utf-8
require 'test/unit'
require '../lib/ruby_plus_plus'
require '../lib/transformers/curly_braces_injector'

class CurlyBracesInjectorTest < Test::Unit::TestCase

  def setup
    @transformer = RubyPlusPlus::CurlyBracesInjector.new
  end

  def test_if_statement
    input = "
x = 20
if (x > 10)
y = 4
end
"
    output = "
x = 20
if (x > 10) {
y = 4
}
"
    assert_equal(@transformer.transform(input), output)
  end

  def test_if_else_statement
    input = "
x = 20
if (x > 10)
y = 4
else
y = 6
end
"
    output = "
x = 20
if (x > 10) {
y = 4
} else {
y = 6
}
"
    assert_equal(@transformer.transform(input), output)
  end

    def test_else_if_statement
    input = "
x = 20
if (x > 10)
y = 4
else if (x > 5)
y = 3
else
y = 2
end
"
    output = "
x = 20
if (x > 10) {
y = 4
} else if (x > 5) {
y = 3
} else {
y = 2
}
"
    assert_equal(@transformer.transform(input), output)
  end

  def test_for_statement
    input = "
x = 20
for (x in 1..10)
  y = 10
end
"
    output = "
x = 20
for (x in 1..10) {
  y = 10
}
"
    assert_equal(@transformer.transform(input), output)
  end

    def test_while_statement
    input = "
x = 20
while (x < 100)
  x -= 1
end
"
    output = "
x = 20
while (x < 100) {
  x -= 1
}
"
    assert_equal(@transformer.transform(input), output)
  end

  def test_multiple_statements
    input = "
x = 0
while (x < 100)
  for (y in 0 .. 10)
    if ((x * y) % 4 == 0)
      z = 4
    else if ((x * y) % 5 == 0)
      z = 5
    else
      z = 0
    end
  end
end
"
    output = "
x = 0
while (x < 100) {
  for (y in 0 .. 10) {
    if ((x * y) % 4 == 0) {
      z = 4
    } else if ((x * y) % 5 == 0) {
      z = 5
    } else {
      z = 0
    }
  }
}
"
    assert_equal(@transformer.transform(input), output)
  end

end

# encoding: utf-8
require 'test/unit'
require '../lib/ruby_plus_plus'
require '../lib/transformers/semi_colon_injector'

class SemiColonInjectorTest < Test::Unit::TestCase

  def setup
    @transformer = RubyPlusPlus::SemiColonInjector.new
  end

  def test_semi_colon_injection
    input = "
x = 20
if (x > 10) {
y = 4
z = 10
a = 10
}"
    output = "
x = 20;
if (x > 10) {
y = 4;
z = 10;
a = 10;
}"
    assert_equal(@transformer.transform(input), output)
  end

end

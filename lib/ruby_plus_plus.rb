# encoding: utf-8

require_relative 'transformer'

# The public interface of RubyPlusPlus, used to perform Ruby to C++ source
# code transformation.
#
# TODO:
# - Force all method calls to use brackets!
class RubyPlusPlus

  # Transforms a block of Ruby source code into an equivalent block of C++
  # source code.
  #
  # ==== Parameters
  # [+code+]  The Ruby code to transform.
  #
  # ==== Returns
  # An equivalent C++ program.
  def transform(code)

    sanitizer = Sanitizer.new
    code = sanitizer.strip_comments(code)
    code = sanitizer.strip_empty_lines(code)

    string_transformer = StringTransformer.new
    code = string_transformer.extract(code)

    code = sanitizer.strip_excess_whitespace(code)
    code = sanitizer.collapse_multi_line_statements(code)

    # This will work in simple cases, but not with blocks!
    #
    # BREAKING CASE: (Or is this a breaking case?)
    #
    # do
    #   i += 1
    # end until i == 10
    #
    # SOLUTION:
    # Block transformer!
    # Need to be careful with semantics here!
    # <TYPE> <CONDITION> do
    #
    # end
    code = sanitizer.collapse_modifiers(code)

    # ------
    # BROKEN: According to last update.
    # Ensure that all control flow conditions are enclosed within brackets.
    code = ConditionTransformer.new.transform(code)

    # Transform Ruby keywords to C++ keywords.
    keyword_transformer = KeywordTransformer.new
    code = keyword_transformer.transform_elsif(code)
    code = keyword_transformer.transform_until_and_unless(code)

    # Identify each variable scope.
    # WARNING: Under development!
    code = TypeInjector.new.transform(code)

    code = ForLoopTransformer.new.transform(code)

    code = CurlyBracesInjector.new.transform(code)

  end

end

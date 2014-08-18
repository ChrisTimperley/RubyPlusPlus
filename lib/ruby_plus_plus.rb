# encoding: utf-8

require_relative 'core/transformer'
require_relative 'core/context'

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
    code = SemiColonInjector.new.transform(code)

    # Reinsert the strings.
    code = string_transformer.restore(code)

    # Use beautifier: AStyle?

    return code

  end

end

# Environment.
# - Variable scoping.
# - Parameters.
# - Instance variables.
# - Class variables.

# for i in 0..5
# -> for(i = 0; i <= 5; i++)
#
# for i in collection
# -> for(i : collection) # Type checking here?
#
# collection.each do |blah|
#
# }
#
# -> for(blah : collection) {
#
# }

# Obstacle Case:
# if x < 2
#   y = 0
# elsif x > 4
#   y = 1
# end
#

# Lists vs. Arrays.
# - Assume everything is a list?
# - Apply optimisations afterwards.

# TypeInjector(environment)
# Type inference.
# Type coercion.

# Find each variable assignment:
# POST-SEMI-COLON: /\w+[^!=]=[^!=;]+;/
# - Do we know the type of this variable already?
# - Where is this variable used?
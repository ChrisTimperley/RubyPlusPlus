# encoding: utf-8
#
# The keyword transformer is used to convert Ruby keywords into appropriate
# C++ equivalents.
class KeywordTransformer < Transformer

  # Converts all "elsif" statements into C++ style "else if".
  def transform_elsif(code)
    code.gsub(/\belsif\b/, "else if")
  end

  # Transforms all "until" and "unless" statements in a given block of code
  # into their equivalent "while" and "if" statement forms.
  def transform_until_and_unless(code)
    code.gsub(/(\b|^)(until|unless)\s+.+/) do |statement|
      type, condition = statement.split(/\s/, 2)
      type = ({'until'=> 'while', 'unless' => 'if'})[type]
      condition = condition.strip[1...-1]
      condition = "(#{condition})" unless   condition.start_with?('(') &&
                                            condition.end_with?(')')
      "#{type} (!#{condition})"
    end
  end

end

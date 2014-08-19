# encoding: utf-8

# The condition transformer ensures that the boolean conditions for all control
# flow statements is enclosed within parentheses.
class RubyPlusPlus::ConditionTransformer < RubyPlusPlus::Transformer

  def transform(code)
    #/(if\s+[^\(\n\)]+)/
    #/\b(if|elsif|while|for|until|unless)\s+[^\(\n\)]+/
    code.gsub(/\b(if|elsif|while|for|until|unless)\s+[^\n]+/) do |statement|

      # Extract the statement type keyword and the condition.
      type, condition = statement.split(/\s/, 2)
      condition = condition.strip

      # To avoid redundancy, remove any brackets enclosing the entire condition.
      if condition[0] == '(' && find_closing_bracket(condition, 0) == condition.length - 1
        condition = condition[1 ... -1]
      end

      # Reformat to ensure that the condition is enclosed by a single pair of parentheses.
      "#{type} (#{condition})"

    end
  end

end

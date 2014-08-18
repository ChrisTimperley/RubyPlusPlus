# encoding: utf-8

# The condition transformer ensures that the boolean conditions for all control
# flow statements is enclosed within parentheses.
class RubyPlusPlus::ConditionTransformer < RubyPlusPlus::Transformer

  def transform(code)
    #/(if\s+[^\(\n\)]+)/
    code.gsub(/\b(if|elsif|else if|while|for|until|unless)\s+[^\(\n\)]+/) do |statement|
      type, condition = statement.split(/\s/, 2)
      "#{type} (#{condition.strip})"
    end
  end

end

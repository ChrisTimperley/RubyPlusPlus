# encoding: utf-8
#
# Transforms Ruby +for+ loops into appropriate C++ equivalents.
#
# ==== Current Limitations
# - Only simple integer range-based iteration is possible.
# - Only supports single variable iteration.
# - Collection-based iteration is not yet implemented.
class RubyPlusPlus::ForLoopTransformer < RubyPlusPlus::Transformer

  # Attempts to transform all Ruby for loops into C++ equivalents.
  def transform(code)
    code = code.gsub(/\bfor\b.+/) do |statement|

      backup = statement

      # Split the loop header into a list of variables and an expression.
      statement = statement[statement.index('(') + 1 ... statement.rindex(')')]
      statement = statement.partition(/\bin\b/)
      variables, expression = statement.first, statement.last.strip
      variables = variables.split(',').map { |v| v.strip }

      # Search for the position of an unenclosed ".." or "...". 
      #
      # NOTE:
      # This also determines whether the range is inclusive or exclusive,
      # even though it doesn't affect the enclosed_by_brackets? computation.
      offset = -1
      pos = nil
      until offset.nil? || !pos.nil?
        offset = expression.index(/\.{2,3}/, offset + 1)
        unless offset.nil?
          type = expression[offset + 2] == '.' ? 2 : 1
          pos = offset unless enclosed_by_brackets?(expression, offset .. offset + type)
        end
      end

      # Handle range-based for loops.
      # Determine the type of range operator and extract its start and end point.
      unless pos.nil?
        r_exclusive = expression[pos + 2] == '.'
        r_dots = r_exclusive ? 3 : 2
        r_start = expression[0 ... pos]
        r_end = expression[pos + r_dots .. -1]
        
        expression =  "#{variables[0]} = #{r_start}; "
        expression << "#{variables[0]} #{r_exclusive ? '!=' : '=='} #{r_end}; "
        expression << "++#{variables[0]}"
        expression = "for (#{expression})"

      # Handle collection iteration based for loops.
      else
        puts "WARNING - UNIMPLEMENTED FUNCTIONALITY REQUIRED: Collection-based for-loop transformation."
      end

      # Return the transformed statement.
      expression

    end
    return code
  end

end

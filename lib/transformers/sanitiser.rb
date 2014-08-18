# encoding: utf-8
#
# The Sanitiser tool is responsible for cleaning up provided code, by
# stripping out comments, empty lines and excess whitespace, as well as
# simplifying certain statements. These subtle transformations are designed to
# make operating on the source code as simple and efficient as possible.
class RubyPlusPlus::Sanitiser < RubyPlusPlus::Transformer

  # Removes all comments from a given block of code.
  #
  # ==== Parameters
  # [+code+]  The code to remove the comments from.
  #
  # ==== Returns
  # The transformed version of the code.
  def strip_comments(code)
    code.gsub(/#.*/, '')
  end

  # Removes all empty lines from a given block of code.
  #
  # ==== Parameters
  # [+code+]  The code to remove the empty lines from.
  #
  # ==== Returns
  # The transformed version of the code.
  def strip_empty_lines(code)
    code.squeeze("\n")
  end

  # Removes all excess whitespace from a given block of code and converts all
  # tabs into spaces.
  #
  # ==== Parameters
  # [+code+]  The code to remove the excess whitespace from.
  #
  # ==== Returns
  # The transformed version of the code.
  #
  # ==== Development
  # This could probably be done in a single regular expression, something like
  # /\s+/, but care needs to be taken not to remove new-lines.
  def strip_excess_whitespace(code)
    code.gsub(/\t/, ' ').squeeze(' ')
  end

  # Collapses all modifiers into their equivalent statements.
  def collapse_modifiers(code)
    code.gsub(/.+\W(if|unless|while|until)\W.+/) do |statement|
      statement, modifier, condition = statement.partition(/\W(if|unless|while|until)\W/)
      statement = (statement + modifier.slice!(0)).strip
      condition = (condition + modifier.slice!(-1)).strip
      "#{modifier} #{condition}\n#{statement}\nend"
    end
  end

  # Collapses all multiple line statements in a given block of code into
  # their single line equivalents.
  #
  # ==== Parameters
  # [+code+]  The block of code to be transformed.
  #
  # ==== Returns
  # The transformed version of the code.
  #
  # ==== Development
  # * Move +operations+ into a static class variable?
  def collapse_multi_line_statements(code)
    operations = [
      ' &&' , ' and',
      ' !'  , ' not',
      ' ||' , ' or',
      ' *'  ,
      ' +'  ,
      ' -'  ,
      ' /'  ,
      ' ,'  ,
      ' ==' ,
      ' ='  ,
    ]

    collapsed_form = ""
    line_buffer = ""
    open_curly_brackets = 0
    open_square_brackets = 0
    code.lines.map(&:strip).each do |line|

      line_buffer << ' ' + line

      # Count the number of opening and closing brackets on this line and apply
      # the difference to the current tally.
      open_curly_brackets += line.count('(') - line.count(')')
      open_square_brackets += line.count('[') - line.count(']')

      # If all brackets have been closed, and this line doesn't end with an
      # unfinished operation, then add the line to the collapsed form and clear
      # the buffer.
      if  open_curly_brackets == 0  &&
          open_square_brackets == 0 &&
          !line.end_with?(*operations)
        collapsed_form << "\n" unless collapsed_form.empty?
        collapsed_form << line_buffer
        line_buffer.clear
      end

    end

    return collapsed_form
  end

end

# encoding: utf-8
#
# The base class used by all source code transformers. Contains a number of
# convenience functions used for simple source code inspection and manipulation.
class RubyPlusPlus::Transformer

  # Determines whether some region within a string is enclosed within brackets.
  #
  # ==== Parameters
  # [+str+]     The string to check.
  # [+region+]  The region of the string to check for enclosure (as a Range).
  #
  # ==== Returns
  # True if the region is enclosed by brackets, otherwise false.
  def enclosed_by_brackets?(str, region)
    open_brackets = 0
    str[0 ... region.begin].each_char do |c|
      open_brackets += 1 if c == '('
      open_brackets -= 1 if c == ')'
    end
    open_brackets != 0
  end

  # Finds the location of the closing bracket for an opening at a given
  # position along a provided string.
  #
  # ==== Parameters
  # [+str+]     The string to search.
  # [+pos+]     The position of the opening bracket along the string.
  #
  # ==== Returns
  # The index of the closing bracket along the string, or nil if the correct
  # closing bracket cannot be found.
  def match_open_bracket(str, pos)

  end
  alias_method :find_closing_bracket, :match_open_bracket

  # Finds the location of the closing bracket for a closing at a given
  # position along a provided string.
  #
  # ==== Parameters
  # [+str+]     The string to search.
  # [+pos+]     The position of the closing bracket along the string.
  #
  # ==== Returns
  # The index of the opening bracket along the string, or nil if the correct
  # opening bracket cannot be found.
  def match_closing_bracket(str, pos)
    
  end
  alias_method :find_opening_bracket, :match_closing_bracket

end

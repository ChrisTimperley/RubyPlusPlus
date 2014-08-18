# encoding: utf-8
#
# The string transformer is responsible for finding all the strings in the
# program, storing them in a buffer, and replacing them with indexed
# placeholders, before re-inserting the strings back into their correct
# positions within the program.
class RubyPlusPlus::StringTransformer < RubyPlusPlus::Transformer

  private

  # An indexed list of strings extracted from some provided source code,
  # ordered by position ascendingly.
  attr_reader :buffer

  public

  # Constructs a new string transformer.
  def initialize
    @buffer = []
  end

  # Extracts all enclosed strings from a given program, stores them in a
  # temporary buffer and replaces them with indexed placeholders.
  def extract(code)
    @buffer = []
    code.gsub(/\"(\\.|[^\"])*\"/) do |match|
      @buffer << match
      "$STRING_#{@buffer.length - 1}$"
    end
  end

  # Reinserts the extracted strings back into the given program before
  # clearing the contents of the string buffer.
  def restore(code)
    code = code.gsub(/\$STRING_(\d)+\$/) { |n| @buffer[n[8...-1].to_i] }
    @buffer.clear
    code
  end

end

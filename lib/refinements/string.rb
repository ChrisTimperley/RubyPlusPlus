# encoding: utf-8

class String

  # Indents this string by a given number of spaces.
  def indent(spaces = 2)
    spaces = " " * spaces
    self.lines.map { |l| spaces + l }.join
  end

end

# encoding: utf-8
#
# Used to store information about a particular context within a Ruby program.
class RubyPlusPlus::Context

  # The line that this context begins at.
  attr_reader :start_line

  # The line that this context ends at.
  attr_reader :end_line

  # The parent context of this context.
  attr_reader :parent

  # A hash of the variables belonging to this scope.
  attr_reader :variables
  protected :variables

  # Constructs a new context.
  #
  # ==== Parameters
  # [+start_line+]  The line that this context begins at.
  # [+end_line+]    The line that this context ends at.
  # [+parent+]      The parent context of this context.
  def initialize(start_line, end_line, parent = nil)
    @start_line = start_line
    @end_line = end_line
    @parent = parent
    @variables = {}
  end

  # Checks whether a given variable has been declared within
  # this context (does not check the parent contexts).

  # Checks whether a given variable exists within this context.
  #
  # ==== Parameters
  # [+variable+]  The name of the variable to check for.
  #
  # ==== Returns
  # True if this variable exists.
  def exists?(variable)

  end

end

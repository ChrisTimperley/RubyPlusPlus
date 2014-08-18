# encoding: utf-8

class RubyPlusPlus::TypeInjector < RubyPlusPlus::Transformer

  # Used to hold details of a context whilst it is being constructed.
  TemporaryContext = Struct.new(
    :start_line,
    :open_blocks,
    :parent,
    :end_line)

  def transform(code)

    # Identify each context within the given code.
    open_blocks = 0
    context = TemporaryContext.new(0, 0, nil, nil)
    code.lines.each_with_index do |line, line_no|
      line.match(/\b(for|while|if|else)\b/) do |type|
        type = type[0]
        if ['for', 'while'].include?(type)
          context = TemporaryContext.new(
            line_no,
            context.open_blocks,
            context,
            nil)
        end
        open_blocks += 1
      end
      line.match(/\bend\b/) do
        open_blocks -= 1
        if context.open_blocks == open_blocks
          context.end_line = line_no
          context = context.parent
        end
      end
    end

    """
    # Find all variable assignments.
    code.gsub(/\w+\s*=[^=].+/) do |statement|
      name, expression = statement.split('=', 2).map { |v| v.strip }

      # Do we already know the type of this variable?
      # If so, then carry on!

    end
    """

    code

  end

end

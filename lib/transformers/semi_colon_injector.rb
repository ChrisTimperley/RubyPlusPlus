# encoding: utf-8
#
# Responsible for injecting semi-colons at the end of every statement.
class RubyPlusPlus::SemiColonInjector < RubyPlusPlus::Transformer

  # Injects semi-colons at the end of each statement in the provided source
  # code.
  def transform(code)
    code.lines.map { |l|
      
      # Remove the trailing line break and remove all leading and trailing
      # whitespace.
      l = l.chomp.strip

      # Do not add semi-colons to control-flow lines or empty lines.
      unless  l.empty? ||
              l.lstrip.start_with?('}') ||
              l.rstrip.end_with?('{')
        l = l.rstrip + ';'
      end

      # Return the transformed line.
      l

    }.join("\n")
  end

end

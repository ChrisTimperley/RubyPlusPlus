# encoding: utf-8
#
# Injects curly braces into the appropriate places, removing any "do" or "end"
# statements in the process.
class RubyPlusPlus::CurlyBracesInjector < RubyPlusPlus::Transformer

  # Injects curly braces into the provided source code.
  def transform(code)
    code = code.gsub(/\b(if|else|for|while).*/) do |statement|
      statement.strip + " {"
    end
    return code.gsub(/\bend/, "}").gsub(/\belse/, "} else")
  end
  
end

require 'rubygems'
require 'autoloader'
require 'pathname'
AutoLoader << Pathname(__FILE__).dirname

class ReTemplate
  include AutoLoader

  attr_accessor :nodes
  attr_writer :expressions
  def expressions
    @expressions ||= {}
  end
  
  def add_text_expressions *args
    hash = args.last.kind_of?(Hash) ? args.pop : {}
    args.each do |field|
      hash[field] = field
    end
    hash.each_pair do |key, value|
      self.expressions[/#{Regexp.escape key}/] = value
    end
  end
end
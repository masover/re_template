require 'nokogiri'

class ReTemplate::Html < ReTemplate
  attr_accessor :doc
  def parse! given_doc
    if given_doc.kind_of? String
      self.doc = Nokogiri::HTML.parse(given_doc)
    else
      self.doc = given_doc.dup
    end
    
    self.nodes = []
    
    parse_children! doc
  end
  
  def render values
    nodes.each do |node|
      node.render! values
    end
    doc.dup
  end
  
  class SubTemplate < Text
    attr_accessor :node
    def initialize node, expressions
      self.node = node
      self.expressions = expressions
      self.parse! node
    end
    
    def render! values
      self.node = node.replace(Nokogiri::XML::Text.new(render(values), node.document))
    end
  end
  
  protected
    def parse_children! node
      if node.kind_of? Nokogiri::XML::Text
        nodes << SubTemplate.new(node, expressions)
      else
        node.children.each do |n|
          parse_children! n
        end
      end
    end
end
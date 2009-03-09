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
    doc.to_s
  end
  
  class SubTemplate < Text
    attr_accessor :node
    def initialize node, expressions
      self.node = node
      self.expressions = expressions
      self.parse! node.text
    end
    
    def render! values
      new_node = Nokogiri::XML::Text.new(render(values), node.document)
      node.replace(new_node)
      self.node = new_node
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
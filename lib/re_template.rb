class ReTemplate
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
  
  class ReTemplate::Text < ReTemplate
    def parse! string
      self.nodes = [string]
      expressions.each_key do |expression|
        self.nodes = self.nodes.map do |node|
          if node.kind_of? String
            result = []
            rest = node
            while match = expression.match(rest)
              result << match.pre_match
              result << expression
              rest = match.post_match
            end
            result << rest
            result.reject{|x| x == ''}
          else
            # It's not a string, so leave it alone
            node
          end
        end.flatten
      end
    end
    
    def render values
      result = ''
      nodes.each do |node|
        if node.kind_of? String
          result << node
        else
          result << values[expressions[node]]
        end
      end
      result
    end
  end
end
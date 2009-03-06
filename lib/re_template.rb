class ReTemplate
  attr_accessor :expressions, :nodes
  
  class ReTemplate::Text < ReTemplate
    def parse! string
      self.nodes = [string]
      expressions.each do |expression|
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
  end
end
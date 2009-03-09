class ReTemplate::Html < ReTemplate::Text
  def render values
    our_values = values.dup
    values.each_pair do |k,v|
      our_values[k] = CGI.escapeHTML v
    end
    super our_values
  end
end
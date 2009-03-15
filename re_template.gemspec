# This file is NOT generated, believe it or not!
# Shameful, I know.

DEP = ['masover-autoloader', ['~> 0.0.1']]

Gem::Specification.new do |s|
  s.name = 're_template'
  s.version = '0.0.1.1'
  s.date = '2009-03-15'
  s.summary = 'Simple, Regular Expression powered template engine. Intelligently handles HTML input.'
  s.email = 'dave@3mix.com'
  s.has_rdoc = false
  s.authors = ['David Masover']
  s.files = ['README', 'lib/re_template.rb', 'lib/re_template/text.rb', 'lib/re_template/html.rb']
  
  # Lifted from elsewhere.
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2
 
    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency *DEP
    else
      s.add_dependency *DEP
    end
  else
    s.add_dependency *DEP
  end
end
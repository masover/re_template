# This file is NOT generated, believe it or not!
# Shameful, I know.

DEPS = [
  ['autoloader', ['~> 0.0']],
  ['nokogiri', ['~> 1.4']]
]

Gem::Specification.new do |s|
  s.name = 're_template'
  s.version = '0.0.1.2'
  s.date = '2009-03-15'
  s.summary = 'Simple, Regular Expression powered template engine.'
  s.description = 'Intelligently handles HTML input, and is meant to safely handle untrusted templates and substitution variables. Basically, it\'s designed for mail merge.'
  s.email = 'ninja@slaphack.com'
  s.homepage = 'http://github.com/masover/re_template'
  s.has_rdoc = false
  s.authors = ['David Masover']
  s.files = ['README', 'lib/re_template.rb', 'lib/re_template/text.rb', 'lib/re_template/html.rb']
  
  DEPS.each do |dep|
    # Lifted from elsewhere.
    if s.respond_to? :specification_version then
      current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
      s.specification_version = 2
   
      if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
        s.add_runtime_dependency *dep
      else
        s.add_dependency *dep
      end
    else
      s.add_dependency *dep
    end
  end
end

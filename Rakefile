require 'pathname'
root = Pathname(__FILE__).dirname
$: << root.join('lib').to_s
Dir.glob(root.join('rake/**/*.rb').to_s).each do |file|
  require file
end

# Designed for Test::Spec

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.name = :spec
  t.pattern = 'spec/**/*_spec.rb'
  t.ruby_opts.push '-r', 'spec/spec_helper'
end
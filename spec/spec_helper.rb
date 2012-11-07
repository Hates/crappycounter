require 'rubygems'
require 'bundler'

require 'rspec'

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'crappy_counter'

RSpec::Matchers.define :have_key do |expected|
  match do |redis|
    redis.exists(expected)
  end
end

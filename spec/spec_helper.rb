ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/autorun'
require 'pry'

Dir[Rails.root.join("../support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.order = "random"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

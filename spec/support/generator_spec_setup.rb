require 'generator_spec/test_case'

RSpec.configure do |config|
  config.include GeneratorSpec::TestCase, type: :generator
end

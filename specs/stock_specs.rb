require("minitest/autorun")
require('minitest/reporters')
require_relative('../stock.rb')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestStock < MiniTest::Test

end

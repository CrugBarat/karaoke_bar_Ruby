require("minitest/autorun")
require('minitest/reporters')
require_relative('../classes/stock.rb')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestStock < MiniTest::Test

end

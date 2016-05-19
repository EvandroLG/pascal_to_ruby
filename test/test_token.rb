require_relative '../src/token'
require 'test/unit'

class TestToken < Test::Unit::TestCase
  def test_set_parameters
    token = Token.new('INTEGER', '2')

    assert_equal('INTEGER', token.type)
    assert_equal('2', token.value)
  end

  def test_to_str
    token = Token.new('INTEGER', '2')
    assert_equal('Token(INTEGER, 2)', token.to_str)
  end
end

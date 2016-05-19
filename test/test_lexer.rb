require_relative '../src/lexer'
require 'test/unit'

class TestLexer < Test::Unit::TestCase
  def test_error
    lexer = Lexer.new '2+2'
    assert_raise(RuntimeError, 'Invalid syntax') { lexer.error }
  end
end

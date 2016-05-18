require_relative '../src/lexer'
require_relative '../src/interpreter'
require 'test/unit'

class TestInterpreter < Test::Unit::TestCase
  def test_error
    lexer = Lexer.new '2+2'
    interpreter = Interpreter.new lexer
    assert_raise(RuntimeError, 'Invalid syntax') { interpreter.error } 
  end
end

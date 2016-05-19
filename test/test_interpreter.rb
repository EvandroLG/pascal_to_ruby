require_relative '../src/lexer'
require_relative '../src/interpreter'
require 'test/unit'

class TestInterpreter < Test::Unit::TestCase
  def test_error
    lexer = Lexer.new '2+2'
    interpreter = Interpreter.new lexer

    assert_raise(RuntimeError, 'Invalid syntax') { interpreter.error } 
  end

  def test_result_with_sum
    lexer = Lexer.new '2+2'
    interpreter = Interpreter.new lexer

    assert_equal(4, interpreter.expr)
  end

  def test_result_with_plus
    lexer = Lexer.new '2-2'
    interpreter = Interpreter.new lexer

    assert_equal(0, interpreter.expr)
  end

  def test_result_with_mul
    lexer = Lexer.new '2*3'
    interpreter = Interpreter.new lexer

    assert_equal(6, interpreter.expr)
  end

  def test_result_with_div
    lexer = Lexer.new '6/3'
    interpreter = Interpreter.new lexer

    assert_equal(2, interpreter.expr)
  end
end

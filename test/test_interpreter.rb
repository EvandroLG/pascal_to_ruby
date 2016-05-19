require_relative '../src/lexer'
require_relative '../src/interpreter'
require 'test/unit'

class TestInterpreter < Test::Unit::TestCase
  def test_error
    lexer = Lexer.new '2+2'
    interpreter = Interpreter.new lexer

    assert_raise(RuntimeError, 'Invalid syntax') { interpreter.error } 
  end

  def verify_calc(param, expected)
    lexer = Lexer.new param
    interpreter = Interpreter.new lexer

    assert_equal(expected, interpreter.expr)
  end

  def test_result_with_sum
    verify_calc('2+2', 4)
  end

  def test_result_with_plus
    verify_calc('2-2', 0)
  end

  def test_result_with_mul
    verify_calc('2*3', 6)
  end

  def test_result_with_div
    verify_calc('6/3', 2)
  end
end

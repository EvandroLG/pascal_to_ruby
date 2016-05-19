require_relative '../src/lexer'
require 'test/unit'

class TestString < Test::Unit::TestCase
  def test_is_number_returns_true
    assert '123'.is_number?
  end

  def test_is_number_returns_false
    assert_equal(false, 'a123'.is_number?)
  end

  def test_is_space_returns_true
    assert '  '.is_space?
  end

  def test_is_number_returns_false
    assert_equal(false, 'abcd'.is_space?)
  end
end

class TestLexer < Test::Unit::TestCase
  def test_error
    lexer = Lexer.new '2+2'
    assert_raise(RuntimeError, 'Invalid syntax') { lexer.error }
  end
end

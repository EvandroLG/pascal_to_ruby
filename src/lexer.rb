require './token'

class String
  def is_number?
    self.match(/^(\d)+$/)
  end

  def is_space?
    self.match(/^\s*$/)
  end
end

INTEGER, PLUS, MINUS, MUL, DIV, EOF = 'INTEGER', 'PLUS', 'MINUS', 'MUL', 'DIV', 'EOF'

class Lexer
  def initialize(text)
    @text = text
    @pos = 0
    @current_char = @text[@pos]
  end

  def error
    raise 'Invalid character'
  end

  def advance
    @pos += 1

    if @pos > @text.length - 1
      @current_char = nil
    else
      @current_char = @text[@pos]
    end
  end

  def skip_whitespace
    while @current_char and @current_char.is_space?
      advance
    end
  end

  def integer
    result = ''

    while @current_char and @current_char.is_number?
      result += @current_char
      advance
    end

    result.to_i
  end

  def get_next_token
    while @current_char
      if @current_char.is_space?
        skip_whitespace
        next
      end

      if @current_char.is_number?
        return Token.new(INTEGER, integer)
      end

      if @current_char == '+'
        advance
        return Token.new(PLUS, '+')
      end

      if @current_char == '-'
        advance
        return Token.new(MINUS, '-')
      end

      if @current_char == '*'
        advance
        return Token.new(MUL, '*')
      end

      if @current_char == '/'
        advance
        return Token.new(DIV, '/')
      end

      error
    end

    Token.new(EOF, nil)
  end
end

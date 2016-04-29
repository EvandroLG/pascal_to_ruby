require './token'

class String
  def is_number?
    self.match(/^(\d)+$/)
  end

  def is_space?
    self.match(/^\s*$/)
  end
end

INTEGER, PLUS, MINUS, EOF = 'INTEGER', 'PLUS', 'MINUS', 'EOF'

class Interpreter
  def initialize(text)
    @text = text
    @pos = 0
    @current_token = nil
  end

  def error
    raise 'Error parsing input'
  end

  def advance
    @pos += 1

    if @pos > @text.length - 1
      @current_char = @text[@pos]
    else
      @current_char = @text[@pos]
    end
  end

  def skip_whitespace
    while @current_char and @current_char.is_number?
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
        skipe_whitespace
        continue
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

      error
    end

    Token.new(EOF, nil)
  end

  def eat(token_type)
    if @current_token.type == token_type then
      @current_token = get_next_token()
      return
    end

    error
  end

  def expr
    @current_token = get_next_token

    left = @current_token
    eat(INTEGER)

    op = @current_token
    if op == PLUS
      eat(PLUS)
    else
      eat(MINUS)
    end

    right = @current_token
    eat(INTEGER)

    if op.type == PLUS
      return left.value + right.value
    end

    left.value - right.value
  end
end

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
    @current_char = @text[@pos]
  end

  def error
    raise 'Error parsing input'
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

      error
    end

    Token.new(EOF, nil)
  end

  def eat(token_type)
    if @current_token.type == token_type then
      @current_token = get_next_token
      return
    end

    error
  end

  def term
    token = @current_token
    eat(INTEGER)

    token.value
  end

  def expr
    @current_token = get_next_token
    result = term

    while [PLUS, MINUS].include? @current_token.type
      token = @current_token

      if token.type == PLUS
        eat(PLUS)
        result = result + term
      elsif  token.type == MINUS
        eat(MINUS)
        result = result - term
      end
    end

    result
  end
end

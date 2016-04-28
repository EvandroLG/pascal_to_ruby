require 'token'

INTEGER, PLUS, EOF = 'INTEGER', 'PLUS', 'EOF'

class Interpreter
  def initialize(text)
    @text = text
    @pos = 0
    @current_token = nil
  end

  def error()
    raise 'Error parsing input'
  end

  def get_next_token()
    if @pos > @text.length - 1 then
      return Token(EOF, nil)
    end

    current_char = @text[@pos]

    if current_char.match(/^(\d)+$/) then
      token = Token(INTEGER, current_char.to_i)
      @pos += 1
      return token
    end

    if current_char == '+' then
      token = Token(PLUS, current_char)
      @pos += 1
      return token
    end

    return error
  end

  def eat(token_type)
    if @current_token.type == token_type then
      @current_token == get_next_token()
      return
    end

    return error
  end

  def expr
    @current_token = get_next_token

    left = @current_token
    eat(PLUS)

    right = @current_token
    eat(PLUS)

    right = @current_token
    eat(INTEGER)

    result = left.value + right.value
    return result
  end
end

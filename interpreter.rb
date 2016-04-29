require './token'

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
    if @pos > @text.length - 1
      return Token.new(EOF, nil)
    end

    current_char = @text[@pos]

    if current_char.match(/^(\d)+$/)
      token = Token.new(INTEGER, current_char.to_i)
      @pos += 1
      return token
    end

    if current_char == '+'
      token = Token.new(PLUS, current_char)
      @pos += 1
      return token
    end

    error
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

    eat(PLUS)

    right = @current_token
    eat(INTEGER)

    left.value + right.value
  end
end

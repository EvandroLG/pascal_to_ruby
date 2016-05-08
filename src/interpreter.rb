class Interpreter
  def initialize(lexer)
    @lexer = lexer
    @current_token = @lexer.get_next_token
  end

  def error
    raise 'Invalid syntax'
  end

  def eat(token_type)
    if @current_token.type == token_type
      @current_token = @lexer.get_next_token
    else
      error
    end
  end

  def factor
    token = @current_token
    eat(INTEGER)
    token.value
  end

  def term
    result = factor

    while [MUL, DIV].include? @current_token.type do
      token = @current_token

      if token.type == MUL
        eat(MUL)
        result = result * factor
      else
        eat(DIV)
        result = result / factor
      end
    end

    result
  end

  def expr
    result = term

    while [PLUS, MINUS].include? @current_token.type
      token = @current_token

      if token.type == PLUS
        eat(PLUS)
        result = result + term
      else
        eat(MINUS)
        result = result - term
      end
    end

    result
  end
end

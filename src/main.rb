require './lexer'
require './interpreter'

while true
  if __FILE__ == $0
    text = gets.chomp
    lexer = Lexer.new text
    interpreter = Interpreter.new lexer
    puts interpreter.expr
  end
end

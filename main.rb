require './interpreter'

if __FILE__ == $0
  text = gets.chomp
  interpreter = Interpreter.new text
  puts interpreter.expr
end

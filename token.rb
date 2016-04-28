class Token
  def initialize(type, value)
    @type = type
    @value = value
  end

  def to_str()
    'Token(%s, %s)' % [@type, @value]
  end
end

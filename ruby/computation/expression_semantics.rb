class Number < Struct.new(:value)
  def inspect
    "<<#{self}>>"
  end

  def evaluate(environment)
    self
  end

  def to_ruby
    "-> e { #{value.inspect} }"
  end
end

class Boolean < Struct.new(:value)
  def inspect
    "<<#{self}>>"
  end

  def evaluate(environment)
    self
  end

  def to_ruby
    "-> e { #{value.inspect} }"
  end
end

class Variable < Struct.new(:name)
  def inspect
    "<<#{self}>>"
  end

  def evaluate(environment)
    environment[name]
  end

  def to_ruby
    "-> e { e[#{name.inspect}]}"
  end
end

class Add < Struct.new(:left, :right)
  def inspect
    "<<#{self}>>"
  end

  def evaluate(environment)
    Number.new(left.evaluate(environment).value + right.evaluate(environment).value)
  end

  def to_ruby
    "-> e { (#{left.to_ruby}).call(e) + (#{right.to_ruby}).call(e) }"
  end
end

class Multiply < Struct.new(:left, :right)
  def inspect
    "<<#{self}>>"
  end

  def evaluate(environment)
    Number.new(left.evaluate(environment).value * right.evaluate(environment).value)
  end

  def to_ruby
    "-> e { (#{left.to_ruby}).call(e) * (#{right.to_ruby}).call(e) }"
  end
end

class LessThan < Struct.new(:left, :right)
  def inspect
    "<<#{self}>>"
  end

  def evaluate(environment)
    Boolean.new(left.evaluate(environment).value < right.evaluate(environment).value)
  end

  def to_ruby
    "-> e { (#{left.to_ruby}).call(e) < (#{right.to_ruby}).call(e) }"
  end
end

class Assign < Struct.new(:name, :expression)
  def inspect
    "<<#{self}>>"
  end

  def evaluate(environment)
    environment.merge({ name => expression.evaluate(environment) })
  end

  def to_ruby
    "-> e { e.merge({ #{name.inspect} => (#{expression.to_ruby}).call(e) }) }"
  end
end

class DoNothing
  def inspect
    "<<#{self}>>"
  end

  def evaluate(environment)
    environment
  end

  def to_ruby
    '->e { e }'
  end
end

class If < Struct.new(:condition, :consequence, :alternative)
  def evaluate(environment)
    case condition.evaluate(environment)
    when Boolean.new(true)
      consequence.evaluate(environment)
    when Boolean.new(false)
      alternative.evaluate(environment)
    end
  end

  def to_ruby
    "-> e { if (#{condition.to_ruby}).call(e)" +
      " then (#{consequence.to_ruby}).call(e)" + 
      " else (#{alternative.to_ruby}).call(e)" + 
      " end }"
  end
end

class Sequence < Struct.new(:first, :second)
  def evaluate(environment)
    second.evaluate(first.evaluate(environment))
  end

  def to_ruby
    "-> e { (#{second.to_ruby}).call((#{first.to_ruby}).call(e)) }"
  end
end

class While < Struct.new(:condition, :body)
  def evaluate(environment)
    case condition.evaluate(environment)
    when Boolean.new(true)
      evaluate(body.evaluate(environment))
    when Boolean.new(false)
      environment
    end
  end

  def to_ruby
    "-> e {" +
      " while (#{condition.to_ruby}).call(e); e = (#{body.to_ruby}).call(e); end;" +
      " e" +
      " }"
  end
end

statement = While.new(
  LessThan.new(Variable.new(:x), Number.new(5)),
  Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(3)))
)
p statement.to_ruby
proc = eval(statement.to_ruby)
p proc.call({ x: 1 })
# statement = Assign.new(:y, Add.new(Variable.new(:x), Number.new(1)))
# p statement
# p statement.to_ruby
# proc = eval(statement.to_ruby)
# p proc.call({ x: 3 })

# p Add.new(Variable.new(:x), Number.new(1)).to_ruby
# p LessThan.new(Add.new(Variable.new(:x), Number.new(1)), Number.new(3)).to_ruby

# environment = { x: 3 }
# proc = eval(Add.new(Variable.new(:x), Number.new(1)).to_ruby)
# p proc.call(environment)

# proc = eval(LessThan.new(Add.new(Variable.new(:x), Number.new(1)), Number.new(3)).to_ruby)
# p proc.call(environment)
# p Number.new(5).to_ruby
# p Boolean.new(false).to_ruby
# proc = eval(Number.new(5).to_ruby)
# p proc.call({})

# proc = eval(Boolean.new(false).to_ruby)
# p proc.call({})

# expression = Variable.new(:x)
# p expression
# p expression.to_ruby
# proc = eval(expression.to_ruby)
# p proc
# p proc.call({ x: 7 })

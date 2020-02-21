# before
def charge(amount, credit_card_number)
  begin
    connection = CreditCardServer.connect()
    connection.send(amount, credit_card_number)
  rescue IOError => e
    Logger.log "Could not submit order #{@order_number} to the server: #{e}"
    return nil
  ensure
    connection.close
  end
end

# after
def charge(amount, credit_card_number)
  connect do |connection|
    connection.send(amount, credit_card_number)
  end
end

def connect
  begin
    connection = CreditCardServer.connect()
    yield connection
  rescue IOError => e
    Logger.log "Could not submit order #{@order_number} to the server: #{e}"
    return nil
  ensure
    connection.close
  end
end

# example
# before
class Person
  attr_reader :mother, :children, :name

  def initialize(name, date_of_birth, date_of_death = nil, mother = nil)
    @name, @mother = name, mother
    @date_of_birth, @date_of_death = date_of_birth, date_of_death
    @children = []
    @mother.add_child(self) if @mother
  end

  def add_children(child)
    @children << child
  end

  def number_of_living_descendents
    children.inject(0) do |count, child|
      count += 1 if child.alive?
      count + child.number_of_living_descendents
    end
  end

  def number_of_descendents_named(name)
    children.inject(0) do |count, child|
      count += 1 if child.name == name
      count + child.number_of_descendents_named(name)
    end
  end

  def alive?
    @date_of_death.nil?
  end
end

# after
class Person
  attr_reader :mother, :children, :name

  def initialize(name, date_of_birth, date_of_death = nil, mother = nil)
    @name, @mother = name, mother
    @date_of_birth, @date_of_death = date_of_birth, date_of_death
    @children = []
    @mother.add_child(self) if @mother
  end

  def add_children(child)
    @children << child
  end

  def number_of_living_descendents
    count_descendent_matching { |descendent| descendent.alive? }
  end

  def number_of_descendents_named(name)
    count_descendent_matching { |descendent| descendent.name == name }
  end

  def alive?
    @date_of_death.nil?
  end

  protected

  def count_descendent_matching(&block)
    children.inject(0) do |count, child|
      count += 1 if yield child
      count + child.count_descendent_matching(&block)
    end
  end
end

# before
class Person
  attr_reader :department
end

class Department
  attr_reader :manager

  def initialize(manager)
    @manager = manager
  end
end

# after
class Person
  attr_reader :department

  def manager
    @department.manager
  end  
end

class Department
  attr_reader :manager

  def initialize(manager)
    @manager = manager
  end
end

# or
class Person
  extend Forwardable
  def_delegator :@department, :manager
end

class Department
  attr_reader :manager

  def initialize(manager)
    @manager = manager
  end
end
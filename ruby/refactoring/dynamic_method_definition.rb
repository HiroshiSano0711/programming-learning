# before
def failure
  self.state = :failure
end

def error
  self.state = :error
end

# after
def_each :failure, :error do |method_name|
  self.state = method_name
end


# before
def failure
  self.state = :failure
end

def error
  self.state = :error
end

def success
  self.state = :success
end

# after
class Post
  def self.status(*arg)
    args.each do |arg|
      define_method arg do
        self.status = arg
      end
    end
  end

  status :failure, :error, :success
end

# before
class PostData
  def initialize(post_data)
    @post_data = post_data
  end

  def params
    @post_data[:params]
  end

  def session
    @post_data[:session]
  end
end

# after
class Hash
  def to_module
    hash = self
    Module.new do
      hash.each_pair do |key, value|
        define_method key.to_sym do
          value
        end
      end
    end
  end
end

class PostData
  def initialize(post_data)
    self.extend post_data.to_module
  end
end

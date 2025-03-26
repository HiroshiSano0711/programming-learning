class User < Base
  attr_accessor :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
  end

  def self.find_all
    query = %q{select * from users}
    results = client.query(query)
    results.map {|row| User.new(**row.transform_keys(&:to_sym))}
  end
end

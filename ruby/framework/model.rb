class Model
  @@client = Mysql2::Client.new(
      :host => "localhost",
      :username => 'root',
      :password => 'password',
      :database => 'myframework'
  )

  protected
    def client
      @@client
    end
end

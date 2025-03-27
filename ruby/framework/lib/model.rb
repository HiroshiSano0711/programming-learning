# frozen_string_literal: true

class Model
  @client = Mysql2::Client.new(
    host: 'localhost',
    username: 'root',
    password: 'password',
    database: 'myframework'
  )

  protected

  attr_reader :client
end

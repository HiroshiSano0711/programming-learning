require_relative './model'

module Generator
  class ModelGenerator
    def initialize(name, actions)
      @name = name
      @actions = actions
    end

    def create
      Model.new(@name).create
      # マイグレーションファイルを作成
    end
  end
end

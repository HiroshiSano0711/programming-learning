# frozen_string_literal: true

require_relative 'model'

module Generator
  class ModelGenerator
    def initialize(name:, options:)
      @name = name
      @options = options
    end

    def create
      Model.new(@name, 'model/model.rb.tt').create
      # マイグレーションファイルを作成
    end
  end
end

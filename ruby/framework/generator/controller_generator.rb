# frozen_string_literal: true

require_relative 'controller'
require_relative 'view'

module Generator
  class ControllerGenerator
    def initialize(name:, options: [])
      @name = name
      @options = options
    end

    def create
      Controller.new(@name, 'controller/controller.rb.tt').create
      @options.each { |option| View.new(@name, 'view/default.slim.tt', option).create }
    end
  end
end

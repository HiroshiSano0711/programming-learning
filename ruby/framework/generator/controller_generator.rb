# frozen_string_literal: true

require_relative 'controller'
require_relative 'view'

module Generator
  class ControllerGenerator
    def initialize(name, actions)
      @name = name
      @actions = actions
    end

    def create
      Controller.new(@name, @actions).create
      @actions.each { |action| View.new(@name, action).create }
    end
  end
end

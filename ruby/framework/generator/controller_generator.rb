require_relative './controller'
require_relative './view'

require 'pry'
module Generator
  class ControllerGenerator
    def initialize(name, actions)
      @name = name
      @actions = actions
    end

    def create
      Controller.new(@name).create
      @actions.each do |action|
        View.new(@name, action).create
      end
    end
  end
end

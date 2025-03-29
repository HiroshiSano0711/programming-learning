# frozen_string_literal: true

require_relative 'base'

module Generator
  class Controller < Base
    def source_path
      "#{project_name}/app/controllers"
    end

    def source_file_name
      "#{source_path}/#{snake_case(@name)}/#{snake_case(@name)}_controller.rb"
    end

    def create
      system('mkdir', '-p', "#{source_path}/#{snake_case(@name)}")
      super
    end
  end
end

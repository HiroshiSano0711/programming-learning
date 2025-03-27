# frozen_string_literal: true

require_relative 'base'

module Generator
  class Controller < Base
    def source_path
      "#{project_name}/app/controllers"
    end

    def source_file_name
      "#{source_path}/#{snake_case(@name)}_controller.rb"
    end

    def template_path
      './generator/template/controller/controller.rb.tt'
    end
  end
end

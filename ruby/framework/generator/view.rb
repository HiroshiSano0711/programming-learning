require_relative './base'

module Generator
  class View < Base
    def initialize(name, action)
      @name = name
      @action = action
      @printer = Printer.new
    end

    def source_path
      "#{AppConfig.project_name}/app/views"
    end

    def source_file_name
      "#{source_path}/#{snake_case(@name)}/#{@action}.slim"
    end

    def template_path
      './generator/template/view/default.slim.tt'
    end

    def create
      system('mkdir', '-p', "#{source_path}/#{snake_case(@name)}")
      super
    end
  end
end

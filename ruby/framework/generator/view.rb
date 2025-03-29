# frozen_string_literal: true

require_relative 'base'

module Generator
  class View < Base
    def initialize(name, template_source, action)
      super(name, template_source)
      @action = action
    end

    def source_path
      "#{project_name}/app/views"
    end

    def source_file_name
      "#{source_path}/#{snake_case(@name)}/#{@action}.slim"
    end

    def create
      system('mkdir', '-p', "#{source_path}/#{snake_case(@name)}")
      super
    end
  end
end

# frozen_string_literal: true

require_relative 'base'

module Generator
  class Model < Base
    def source_path
      "#{project_name}/app/models"
    end

    def source_file_name
      "#{source_path}/#{snake_case(@name)}.rb"
    end
  end
end

# frozen_string_literal: true

require_relative 'base'

module Generator
  class Config < Base
    def source_path
      "#{project_name}/config"
    end

    def source_file_name
      "#{source_path}/#{snake_case(@name)}.rb"
    end
  end
end

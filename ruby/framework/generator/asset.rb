# frozen_string_literal: true

require_relative 'base'

module Generator
  class Asset < Base
    def source_path
      "#{project_name}/app/assets"
    end

    def source_file_name
      "#{source_path}/#{snake_case(@name)}.css"
    end
  end
end

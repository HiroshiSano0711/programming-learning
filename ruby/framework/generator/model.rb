# frozen_string_literal: true

require_relative 'base'

module Generator
  class Model < Base
    def source_path
      "#{AppConfig.project_name}/app/models"
    end

    def source_file_name
      "#{source_path}/#{snake_case(@name)}.rb"
    end

    def template_path
      './generator/template/model/model.rb.tt'
    end
  end
end

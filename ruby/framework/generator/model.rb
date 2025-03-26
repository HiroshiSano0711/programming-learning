require_relative './base'

module Generator
  class Model < Base
    def source_path
      "#{AppConfig.project_name}/app/models"
    end

    def source_file_name
      "#{source_path}/#{snake_case(@name)}.rb"
    end

    def create
      File.open(source_file_name, "w") do |f|
        f.write(
          <<~EOS
            class #{@name.split('_').map(&:capitalize).join} < Base
            end
          EOS
        )
      end

      log(source_file_name)
    end
  end
end

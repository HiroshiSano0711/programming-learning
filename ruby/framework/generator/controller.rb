require_relative './base'

module Generator
  class Controller < Base
    def source_path
      "#{AppConfig.project_name}/app/controllers"
    end

    def create
      File.open("#{source_path}/#{snake_case(@name)}_controller.rb", "w") do |f|
        f.write(
          <<~EOS
            class #{@name.split('_').map(&:capitalize).join}Controller < BaseController
            end
          EOS
        )
      end

      log("#{source_path}/#{snake_case(@name)}_controller.rb")
    end
  end
end

require_relative './base'
require 'pry'
module Generator
  class Project < Base
    def create
      default_dir_and_files = {
        'app/assets' => 'assets/style.css',
        'app/models' => 'models/base.rb',
        'app/controllers' => 'controllers/base.rb',
        'app/views' => 'views/application.slim',
        'config' => 'config/routes.rb'
      }

      default_dir_and_files.each do |key, value|
        path = @name + '/' + key
        system('mkdir', '-p', path)
        log path

        FileUtils.cp "#{Dir.getwd}/generator/template/init/#{value}", "#{path}/#{value.split('/').last}"
        log path + '/' + value.split('/').last
      end
    end

    def create_app_config_file(name)
      File.open("./app_config.rb", "w") do |f|
        f.write(
          <<~EOS
            class AppConfig
              def self.project_path
                '#{Dir.getwd}/#{name}'
              end

              def self.project_name
                '#{name}'
              end
            end
          EOS
        )
      end
    end
  end
end

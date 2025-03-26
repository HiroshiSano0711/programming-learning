require_relative './base'

module Generator
  class Project < Base
    def initialize(name)
      @name = name
      @template_file = nil
      @printer = Printer.new
    end

    def template_path
      @template_file
    end

    def create
      save_project_path
      project_dirs
      project_default_files
    end

    # 最初にユーザーが作成したプロジェクト名を保存しておかないとプロジェクトのリソースパスがわからない
    def save_project_path
      File.open("./app_config.rb", "w") do |f|
       f.write(
        <<~EOS
          class AppConfig
            def self.project_path
              '#{Dir.getwd + '/' + @name}'
            end

            def self.project_name
              '#{@name}'
            end
          end
        EOS
      )
      end
    end

    def project_dirs
      default_dir = %w(app/assets app/models app/controllers app/views config)
      default_dir.each do |dir|
        system('mkdir', '-p', "#{@name}/#{dir}")
        log "#{@name}/#{dir}"
      end
    end

    def project_default_files
      default_files = %w(
        app/assets/style.css.tt
        app/models/base.rb.tt
        app/controllers/base.rb.tt
        app/views/application.slim.tt
        config/application.rb.tt
        config/routes.rb.tt
      )
      default_files.each do |file|
        @template_file = "./generator/template/init/#{file}"
        fn = file.delete_suffix('.tt')
        File.open("#{project_root}/#{fn}", "w") do |f|
          f.write(template)
        end

        log(@name + '/' + fn)
      end
    end
  end
end

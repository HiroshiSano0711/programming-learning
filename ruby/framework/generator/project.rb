# frozen_string_literal: true

require_relative 'base'

module Generator
  class Project < Base
    def initialize(name, _option)
      super
      @template_file = nil
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
      @template_file = './generator/template/app_config.rb.tt'
      File.write('./app_config.rb', template)
    end

    def project_dirs
      default_dir = %w[app/assets app/models app/controllers app/views config].freeze
      default_dir.each do |dir|
        system('mkdir', '-p', "#{@name}/#{dir}")
        log "#{@name}/#{dir}"
      end
    end

    def project_default_files
      default_files.each do |file|
        @template_file = "./generator/template/init/#{file}"
        fn = file.delete_suffix('.tt')
        File.write("#{project_root}/#{fn}", template)

        log("#{@name}/#{fn}")
      end
    end

    private

    def default_files
      %w[
        app/assets/style.css.tt
        app/models/base.rb.tt
        app/controllers/base.rb.tt
        app/views/application.slim.tt
        config/application.rb.tt
        config/routes.rb.tt
      ].freeze
    end
  end
end

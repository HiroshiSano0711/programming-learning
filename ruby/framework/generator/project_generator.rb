# frozen_string_literal: true

require_relative 'asset'
require_relative 'model'
require_relative 'controller'
require_relative 'view'
require_relative 'config'

module Generator
  class ProjectGenerator
    def initialize(name, options)
      @name = name
      @options = options
    end

    def create
      save_project_info
      project_dirs
      project_default_files
    end

    # 最初にユーザーが作成したプロジェクト名を保存しておかないとプロジェクトのリソースパスがわからない
    def save_project_info
      template = File.read('./generator/template/app_config.rb.tt')
      File.write('./app_config.rb', ERB.new(template).result(binding))
    end

    def project_dirs
      default_dir = %w[app/assets app/models app/controllers app/views config].freeze
      default_dir.each do |dir|
        system('mkdir', '-p', "#{@name}/#{dir}")
      end
    end

    def project_default_files
      Asset.new('style', 'assets/style.css.tt').create
      Model.new('base', 'model/base.rb.tt').create
      Controller.new('base', 'controller/base.rb.tt').create
      View.new('application', 'view/application.slim.tt').create
      Config.new('application', 'config/application.rb.tt').create
      Config.new('route', 'config/routes.rb.tt').create
    end
  end
end

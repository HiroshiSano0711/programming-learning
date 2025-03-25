require 'yaml'
require_relative '../app_config'
require_relative '../printer'

module Generator
  class FileUtil
    attr_reader :type, :name

    def initialize(type, name)
      @type = type
      @name = name
      @printer = Printer.new
    end

    def create_app_config_file
      File.open("./app_config.rb", "w") do |f|
        f.write(
          <<~EOS
            class AppConfig
              def self.project_name
                '#{name}'
              end
            end
          EOS
        )
      end
    end

    def create_template
      struct = load_struct
      struct = replace_user_def(struct) if type != 'project'
      gen(root, struct)
    end

    private
      def root
        AppConfig.project_name || name
      end

      def load_struct
        YAML.load(File.read(File.join(File.dirname(__FILE__), 'structure', "#{type}.yml")))
      end

      def gen(parent, structure_hash)
        return if structure_hash.class != Hash

        structure_hash.each do |key, values|
          create("#{parent}/#{key}", values)
          gen("#{parent}/#{key}", values)
        end
      end

      def create(path, values)
        unless Dir.exist?(path)
          system('mkdir', '-p', path)
          @printer.gen_log(path)
        end

        file_writer(path, values) if values.instance_of?(Array)
      end

      def replace_user_def(hash)
        hash.each do |key, value|
          value.each do|k, v|
            hash[key][k] = v.map {|str| str.gsub(/{user_def}/, snake_case(name))}
          end
        end
        hash
      end

      def file_writer(path, file_names)
        file_names.each do |name|
          File.open("#{path}/#{name}", "w") do |f|
            f.write(template(path, name))
          end
          @printer.gen_log("#{path}/#{name}")
        end
      end

      def snake_case(str)
        str.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
      end

      def template(path, name)
        case path
        when "#{root}/app/models"
          temp = <<~EOS
            class #{name.split('.').first.split('_').map(&:capitalize).join}
            end
          EOS
        when "#{root}/app/assets"
          temp = ''
        when "#{root}/app/controllers"
          temp = <<~EOS
            class #{name.split('.').first.split('_').map(&:capitalize).join}Controller < Controller
            end
          EOS
        when "#{root}/app/views"
          if name == 'application.slim'
            temp = <<~EOS
              doctype html
              html
                head
                  title #{AppConfig.project_name}
                  meta charset="utf-8"
                body
                  h1 フレームワーク
            EOS
          end
        end
        temp
      end
  end
end

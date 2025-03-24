require 'yaml'
require_relative './printer'
require_relative './app_config'

class Generator
  attr_reader :type, :name

  def initialize(type:, name:)
    @type = type
    @name = name
    @root = AppConfig.project_name || name
    @printer = Printer.new
  end

  def exec
    structure = YAML.load(File.read(File.join(File.dirname(__FILE__), 'structure', "#{type}.yml")))
    gen(@root, structure)
    write_project_info if type === 'project'
  end

  def write_project_info
    File.open("./app_config.rb", "w") do |f|
      f.write(app_config_template(name))
    end
  end

  def app_config_template(name)
    <<~EOS
      class AppConfig
        def self.project_name
          '#{name}'
        end
      end
    EOS
  end

  # 別クラスにして委譲する形にする。
  def template(value)
    case type
    when 'controller'
      <<~EOS
        class #{value.split('.').first.split('_').map(&:capitalize).join} < Controller
        end
      EOS
    when 'model'
      <<~EOS
        class #{value.split('.').first.split('_').map(&:capitalize).join}
        end
      EOS
    else
      ''
    end
  end

  private
    def gen(parent, structure_hash)
      return if structure_hash.class != Hash

      structure_hash.each do |key, values|
        path_name = parent + '/' + key

        unless Dir.exist?(path_name)
          system('mkdir', '-p', path_name)
          @printer.gen_log(path_name)
        end

        if values.instance_of?(Array)
          values.each do |val|
            val = val.gsub(/{user_def}/, snake_case(name)) if val.include?('{user_def}')
            File.open("#{path_name}/#{val}", "w") do |f|
              f.write(template(val)) 
            end
            @printer.gen_log("#{path_name}/#{val}")
          end
        end

        gen(path_name, values)
      end
    end

    def snake_case(str)
      str.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end
end

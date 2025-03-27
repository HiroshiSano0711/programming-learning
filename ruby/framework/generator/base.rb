# frozen_string_literal: true

require 'fileutils'
require 'erb'
require_relative '../lib/printer'

module Generator
  class Base
    def initialize(name, actions)
      @name = name
      @actions = actions || []
      @printer = Printer.new
    end

    def project_root
      AppConfig.project_path
    end

    def project_name
      AppConfig.project_name
    end

    def template
      template = File.read(template_path)
      ERB.new(template).result(binding)
    end

    def create
      File.write(source_file_name, template)

      log(source_file_name)
    end

    def log(desc)
      @printer.write(desc)
    end

    def snake_case(str)
      str.gsub('::', '/')
         .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
         .gsub(/([a-z\d])([A-Z])/, '\1_\2')
         .tr('-', '_')
         .downcase
    end
  end
end

# frozen_string_literal: true

require 'fileutils'
require 'erb'
require_relative '../lib/printer'

module Generator
  class Base
    def initialize(name, template_source)
      @name = name
      @template_source = template_source
      @printer = Printer.new
    end

    def project_root
      AppConfig.project_path
    end

    def project_name
      AppConfig.project_name
    end

    def template_path
      './generator/template/'
    end

    def template_source
      "#{template_path}#{@template_source}"
    end

    def template
      ERB.new(File.read(template_source)).result(binding)
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

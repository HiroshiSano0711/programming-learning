require 'fileutils'
require_relative '../printer'

module Generator
  class Base
    def initialize(name)
      @name = name
      @printer = Printer.new
    end

    def project_root
      AppConfig.project_path
    end

    def log(desc)
      @printer.write(desc)
    end

    def snake_case(str)
      str.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end
  end
end

require_relative './file_util'

module Generator
  class Base
    attr_reader :type, :name

    def initialize(type:, name:)
      @file_util = FileUtil.new(type, name)
    end

    def project
      @file_util.create_app_config_file
      @file_util.create_template
    end

    def exec
      @file_util.create_template
    end
  end
end

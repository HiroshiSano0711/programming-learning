# frozen_string_literal: true

require_relative 'app_config'
require_relative 'lib/controller'
require_relative 'lib/model'
require_relative 'lib/router'
require_relative 'lib/printer'

# require File.join(AppConfig.project_path, 'config', 'routes.rb')
require File.join(AppConfig.project_path, 'config', 'application.rb')

app_files = Dir.glob(File.join(AppConfig.project_path, 'app', '**', '*.rb'))
app_files.grep(/base_controller.rb|base.rb\Z/).each { |file| require file }
app_files.grep(/^.*(?<!base_controller.rb|base.rb)\Z/).each { |file| require file }

class App
  attr_reader :router

  def initialize
    @router = Router.new
    @router.draw_routes
  end

  def self.root
    File.dirname(__FILE__)
  end

  def call(env)
    result = router.dispatch(
      request_path: env['REQUEST_PATH'],
      request_method: env['REQUEST_METHOD']
    )
    [result.status, result.headers, result.content]
  end
end

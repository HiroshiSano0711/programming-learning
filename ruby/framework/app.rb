require_relative './app_config.rb'
require_relative './router.rb'
require_relative './controller.rb'

Dir[File.join(AppConfig.project_path, 'app', '**', '*.rb')].each {|file| require file }

class App
  attr_reader :router

  def initialize
    @router = Router.new
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

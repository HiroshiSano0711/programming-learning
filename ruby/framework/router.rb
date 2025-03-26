class Router
  attr_reader :routes

  def initialize
    @routes = Route.routes
  end

  def dispatch(request_path:, request_method:)
    if routes.has_key?(request_path.to_sym)
      controller(path: routes[request_path.to_sym], method: request_method).call
    else
      Controller.new.not_found
    end
  rescue Exception => error
    puts error.message
    puts error.backtrace
    Controller.new.internal_error
  end

  private

  def controller(path:, method:)
    controller_name, action_name = path.split('#')
    klass = Object.const_get "#{controller_name.capitalize}Controller"
    klass.new(name: controller_name, method: method, action: action_name.to_sym)
  end
end

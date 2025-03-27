# frozen_string_literal: true

class Router
  attr_reader :routes

  def initialize
    @routes = {}
  end

  def dispatch(request_path:, request_method:)
    if routes.key?(request_path.to_sym)
      controller_class(path: routes[request_path.to_sym], method: request_method).call
    else
      Controller.new.not_found
    end
  rescue StandardError => e
    puts e.message
    puts e.backtrace
    Controller.new.internal_error
  end

  def draw_routes
    routing_set do
      root to: 'main#index'
      get '/users', to: 'user#index'
    end
  end

  private

  def controller_class(path:, method:)
    controller_name, action_name = path.split('#')
    klass = Object.const_get "#{controller_name.capitalize}Controller"
    klass.new(name: controller_name, method: method, action: action_name.to_sym)
  end

  def routing_set
    yield
  end

  def root(to:)
    @routes[:/] = to
  end

  def get(path, to:)
    @routes[:"#{path}"] = to
  end
end

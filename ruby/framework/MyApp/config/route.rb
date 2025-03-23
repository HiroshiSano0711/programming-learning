class Route
  attr_reader :routes

  def initialize
    @routes = {
      '/': 'main#index',
      '/hello': 'main#hello',
      '/posts': 'posts#index',
      '/assets/style.css': 'assets#index'
    }
  end
end

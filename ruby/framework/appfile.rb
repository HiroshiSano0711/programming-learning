require './entry'

class AppFile < Entry
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def create(prefix)
    File.open(prefix, "w") do |f|
      f.write(template()) 
    end
  end

  def template
    return '' unless @name.split('.').last == 'rb'

    <<~EOS
      class #{@name.split('.').first.split('_').map(&:capitalize).join}
        #write your code
      end
    EOS
  end
end

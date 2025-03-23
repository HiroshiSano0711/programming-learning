require './entry'

class AppFile < Entry
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def create(prefix)
    File.open(prefix, "w") do |f|
      # TODO: ディレクトリの種類ごとにテンプレートを分けたい。
      f.write('#write your code') 
    end
  end

  def template
    <<~EOS
      class #{@name.split('.').first.capitalize}
        #write your code
      end
    EOS
  end
end

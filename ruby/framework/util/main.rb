require_relative './generator'

case ARGV[0]
when 'init'
  if ARGV[1].nil?
    p 'プロジェクト名を指定してください。 例： init MyApp'
    exit()
  end

  Generator.new().init(ARGV[1])
when 'generate'
  # model, controllerとかで生成を分けたい。
  # Generator.new(ARGV[1]).exec  
end

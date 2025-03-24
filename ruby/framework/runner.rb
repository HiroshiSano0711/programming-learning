require_relative './generator'

GEN_COMMANDS = %w(project model controller)

if ARGV[2].nil? ||
  !(ARGV[0] == 'g' || ARGV[0] == 'generate') ||
  !(GEN_COMMANDS.include?(ARGV[1]))

  p '生成コマンドの形式は [g | generate] [project | model | controller] <name> です。'
  exit()
end

Generator.new(type: ARGV[1], name: ARGV[2]).exec

require_relative './generator/base'
require_relative './app_config'

COMMANDS = %w(init g)
GEN_OPTIONS = %w(project model controller)

unless COMMANDS.include?(ARGV[0])
  p 'コマンドの種類は [init <project-name> | g <type-name>] です。'
  exit
end

case ARGV[0]
when 'init'
  Generator::Base.new(type: 'project', name: ARGV[1]).project
when 'g'
  if AppConfig.project_name.nil?
    p '最初にプロジェクトを生成してください'
    exit
  elsif !(GEN_OPTIONS.include?(ARGV[1]))
    p '生成コマンドの種類は [project | model | controller]です。'
    exit
  elsif ARGV[2].nil?
    p "#{ARGV[1]}の<name>を指定してください。"
    exit
  end

  Generator::Base.new(type: ARGV[1], name: ARGV[2]).exec
end

# frozen_string_literal: true

require_relative 'app_config'
require_relative 'generator/project_generator'
require_relative 'generator/model_generator'
require_relative 'generator/controller_generator'

COMMANDS = %w[init g].freeze
GEN_OPTIONS = %w[project model controller].freeze

unless COMMANDS.include?(ARGV[0])
  p 'コマンドの種類は [init <project-name> | g <type-name>] です。'
  exit
end

case ARGV[0]
when 'init'
  Generator::ProjectGenerator.new(ARGV[1], ARGV[2..]).create
when 'g'
  if AppConfig.project_path.nil?
    p '最初にプロジェクトを生成してください'
    exit
  elsif !GEN_OPTIONS.include?(ARGV[1])
    p '生成コマンドの種類は [ model | controller]です。'
    exit
  elsif ARGV[2].nil?
    p "#{ARGV[1]}の<name>を指定してください。"
    exit
  end
  klass = Object.const_get "Generator::#{ARGV[1].capitalize}Generator"
  klass.new(name: ARGV[2], options: ARGV[3..]).create
end

if ARGV[0].nil?
  p 'プロジェクト名を指定してください。'
  exit()
end

require './appfile'
require './folder'
require 'json'

class Generator
    def construct_hierarchy(parent, structure_hash)
      return if parent.class == AppFile

      structure_hash.each do |key, value|
        item = key.to_s.match?(/.*[.].*$/) ? AppFile.new(key.to_s) : Folder.new(key.to_s)
        parent.add(item)
        construct_hierarchy(item, value)
      end
    end

    def init
      structure_hash  = File.open("project_structure.json") do |f|
        JSON.load(f)
      end
      project = Folder.new(ARGV[0])

      # 実際にディレクトリやファイルを生成する処理の責務がおかしい気がする。
      construct_hierarchy(project, structure_hash)
      project.create(project.name)
    end
end

Generator.new.init()

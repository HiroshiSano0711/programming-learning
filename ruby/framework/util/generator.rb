require_relative './appfile'
require_relative './folder'
require 'json'

STRUCTURE = {
  "app": {
    "assets": {
      "style.css": nil
    },
    "models": {
      "base.rb": nil
    },
    "controllers": {
      "application_controller.rb": nil
    },
    "views": {
      "index.html": nil
    }
  },
  "config": {
    "route.rb": nil
  }
}

class Generator
  def init(project_name)
    project = Folder.new(project_name)

    # 実際にディレクトリやファイルを生成する処理の責務がおかしい気がする。
    construct_hierarchy(project, STRUCTURE)
    project.create(project.name)
  end

  private
    def construct_hierarchy(parent, structure_hash)
      return if parent.class == AppFile

      structure_hash.each do |key, value|
        item = key.to_s.match?(/.*[.].*$/) ? AppFile.new(key.to_s) : Folder.new(key.to_s)
        parent.add(item)
        construct_hierarchy(item, value)
      end
    end
end

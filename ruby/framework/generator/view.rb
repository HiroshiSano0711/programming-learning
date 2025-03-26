require_relative './base'

module Generator
  class View < Base
    def source_path
      "#{project_root}/app/views"
    end

    def create
      File.open("#{source_path}/#{@name}.slim", "w") do |f|
        f.write(
          <<~EOS
            doctype html
            html
              head
                title #{AppConfig.project_name}
                meta charset="utf-8"
              body
                h1 フレームワーク
          EOS
        )
      end
    end
  end
end

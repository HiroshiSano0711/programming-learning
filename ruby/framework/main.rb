if ARGV[0].nil?
  p 'プロジェクト名を指定してください。'
  exit()
end

class Generator
    def initialize()
      @base_path = "#{__dir__}/#{ARGV[0]}"
    end

    def init_dirs
      %w(app controlers views)
    end

    def create_project_dir
      init_dirs.each do |dir|
        if File.exist?("#{@base_path}/#{dir}")
          print "\t", "\e[m", "\texists\t#{dir}\n"
        else
          print "\t", "\e[32m"
          print "\tcreate\t"
          print "\e[m"
          print "#{dir}\n"
        end

        system 'mkdir', '-p', "#{@base_path}/#{dir}"
      end
    end
end

Generator.new.create_project_dir()

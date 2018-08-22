require 'fileutils'

module MtgScraper

  module Utils

    class FileUtil

      def self.read(path)
        begin
          return File.read(path)
        rescue Exception => e
          return nil
        end
      end

      def self.write(path, text)
        dirname = File.dirname(path)
        unless Dir.exist?(dirname)
          FileUtils.mkdir_p(dirname)
        end
        File.open(path, 'w') do |f|
          f.puts(text)
        end
      end

      def self.cache_dir(name)
        if Module.const_defined?('Rails')
          return Rails.root.join('tmp', name, 'cache').to_s
        end
        spec = Gem::Specification.find_by_name(MtgScraper::NAME)
        gem_root = spec.gem_dir + "/tmp/#{name}/cache"
      end

    end

  end

end

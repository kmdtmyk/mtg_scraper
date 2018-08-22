require 'fileutils'
require 'uri'
require 'pathname'

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

      def self.cache_dir
        dir_name = 'mtg_scraper'
        if Module.const_defined?('Rails')
          return Rails.root.join('tmp', dir_name).to_s
        end
        spec = Gem::Specification.find_by_name(MtgScraper::NAME)
        gem_root = spec.gem_dir + "/tmp/#{dir_name}"
      end

      def self.cache_path(url)
        uri = URI.parse(url)
        path = Pathname.new(cache_dir).join(url.delete_prefix("#{uri.scheme}://")).to_s
        path.to_s.delete_suffix('/')
      end

    end

  end

end

# frozen_string_literal: true

require 'fileutils'
require 'uri'
require 'pathname'

module MtgScraper
  class Cache

    def self.exist?(url)
      File.exist?(path(url))
    end

    def self.read(url)
      path = self.path(url)
      begin
        return File.read(path)
      rescue Exception => e
        return nil
      end
    end

    def self.write(url, content)
      path = self.path(url)
      dirname = File.dirname(path)
      unless Dir.exist?(dirname)
        FileUtils.mkdir_p(dirname)
      end
      File.open(path, 'w') do |f|
        f.puts(content)
      end
    end

    def self.dir
      dir_name = 'mtg_scraper'
      if Module.const_defined?('Rails')
        return Rails.root.join('tmp', dir_name).to_s
      end
      spec = Gem::Specification.find_by_name(MtgScraper::NAME)
      gem_root = spec.gem_dir + "/tmp/#{dir_name}"
    end

    def self.path(url)
      uri = URI.parse(url)
      path = Pathname.new(dir).join(url.delete_prefix("#{uri.scheme}://")).to_s
      path.to_s.delete_suffix('/')
    end

  end
end

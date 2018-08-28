# frozen_string_literal: true

require 'mtg_scraper/cache'

module MtgScraper

  class Page

    def initialize(url)
      @url = url
    end

    def html
      return @html unless @html.nil?
      return read_cache if cached?
      fetch_html
    end

    private

      def cached?
        MtgScraper::Cache.exist?(@url)
      end

      def read_cache
        @html = MtgScraper::Cache.read(@url)
      end

      def write_cache
        MtgScraper::Cache.write(@url, @html)
      end

      def fetch_html
        unless @@last_time.nil?
          sleep_time = @@interval - (Time.now - @@last_time)
          sleep sleep_time if 0 < sleep_time
        end
        @html = MtgScraper::Utils::HtmlUtil.get(@url)
        @@last_time = Time.now
        write_cache
        @html
      end

  end

end

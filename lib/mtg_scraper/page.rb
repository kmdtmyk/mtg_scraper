module MtgScraper

  # Your code goes here...
  class Page

    def initialize(url)
      @url = url
      @cache_path = MtgScraper::Utils::FileUtil.cache_path(@url)
    end

    def html
      return @html unless @html.nil?
      return read_cache if cached?
      fetch_html
    end

    private

      def cached?
        File.exist?(@cache_path)
      end

      def read_cache
        @html = MtgScraper::Utils::FileUtil.read(@cache_path)
      end

      def write_cache
        MtgScraper::Utils::FileUtil.write(@cache_path, @html)
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

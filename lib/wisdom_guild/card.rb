require 'nokogiri'
require 'wisdom_guild/detail'
require 'wisdom_guild/parse_text'
require 'wisdom_guild/parse_html'
require 'wisdom_guild/file_util'
require 'wisdom_guild/html_util'

module WisdomGuild

  class Card

    @@interval = 5
    @@last_time = nil

    def initialize(name)
      @url = Card::name_to_url(name)
      @cache_path = Card::name_to_file_path(name)
    end

    def name
      return nil if error?
      return @name unless @name.nil?
      parse_html
      @name
    end

    def english_name
      return nil if error?
      return @english_name unless @english_name.nil?
      parse_html
      @english_name
    end

    def multiverseid
      return nil if error?
      return @multiverseid unless @multiverseid.nil?
      parse_html
      @multiverseid
    end

    def details
      return nil if error?
      return @details unless @details.nil?
      parse_html
      @details
    end

    def html
      return @html unless @html.nil?
      return read_cache if cached?
      fetch_html
    end

    def cached?
      File.exist?(@cache_path)
    end

    def error?
      return @error unless @error.nil?
      parse_html
      @error
    end

    def to_hash
      {
        name: name,
        english_name: english_name,
        multiverseid: multiverseid,
        details: details.map{ |detail| detail.to_hash },
      }
    end

    private

      def doc
        return @doc unless @doc.nil?
        @doc = Nokogiri::HTML.parse(html)
      end

      def parse_html
        result = ParseHtml.parse(html)
        @error = result[:error]
        return if @error
        @name = result[:name]
        @english_name = result[:english_name]
        @multiverseid = result[:multiverseid]
        @details = result[:details].map{ |detail| Detail.new(detail) }
      end

      def read_cache
        @html = FileUtil.read(@cache_path)
      end

      def write_cache
        FileUtil.write(@cache_path, @html)
      end

      def fetch_html
        unless @@last_time.nil?
          sleep_time = @@interval - (Time.now - @@last_time)
          sleep sleep_time if 0 < sleep_time
        end
        @html = HtmlUtil.get(@url)
        @@last_time = Time.now
        write_cache
        @html
      end

    def self.name_to_url(name)
      'http://whisper.wisdom-guild.net/card/' + URI.escape(name)
    end

    def self.name_to_file_path(name)
      FileUtil.cache_dir + "/#{name}.html"
    end

  end

end

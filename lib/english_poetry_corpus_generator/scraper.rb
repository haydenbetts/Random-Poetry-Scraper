require 'nokogiri'
require 'open-uri'
require 'pry'

class EnglishPoetryCorpusGenerator::Scraper
    attr_accessor :html_doc
    BROWSE_LINK = "https://www.poetryfoundation.org/poets/browse"

    def initialize
        @html_doc = Nokogiri::HTML(open(BROWSE_LINK))
    end

    def scrape_index_page
        html_doc.css(".c-hdgSans").css("h2 a").collect do |node|
            {"name" => node.text,
            "home_page" => node.attr("href")}
        end
    end
end
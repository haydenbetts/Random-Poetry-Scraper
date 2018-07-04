require 'nokogiri'
require 'open-uri'
require 'pry'

class CorpusGenerator::Scraper
    attr_accessor :html_doc
    BROWSE_LINK = "https://w0.poemhunter.com/members/random-poem/"

    def initialize
        self.html_doc = Nokogiri::HTML(open(BROWSE_LINK))
    end

    def scrape_index_page
        poem_name = html_doc.css(".poem").css("h2").text
    end
end
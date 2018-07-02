require 'nokogiri'
require 'open-uri'
require 'pry'

class EnglishPoetryCorpusGenerator::Scraper
    def initialize
    end

    def self.initialize_index_page
        html_doc = Nokogiri::HTML(open("https://www.poetryfoundation.org/poets/browse"))
    end

    def self.scrape_birthdate_ranges
    end
end
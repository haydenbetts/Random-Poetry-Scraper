require 'nokogiri'
require 'open-uri'
require 'pry'

class CorpusGenerator::Scraper
    attr_accessor :html_doc
    ROOT_LINK = "https://w0.poemhunter.com"
    BROWSE_LINK = ROOT_LINK + "/members/random-poem/"

    def initialize
        self.html_doc = Nokogiri::HTML(open(BROWSE_LINK))
    end

    def scrape_poem_page
        poem_attributes = {}
        poem_attributes[:name] = html_doc.css(".poem").css("h2").text
        poem_attributes[:text] = html_doc.css(".poem").css("p").inner_html.gsub("<br>", "\n").gsub(/\r\n[\t]+/, "    ")
        
        if poet_name = html_doc.css(".poet").text
            poem_attributes[:poet] = {}
            poem_attributes[:poet][:name] = poet_name
            poem_attributes[:poet][:profile_url] = ROOT_LINK + html_doc.css(".poem a").attr("href").value
        end

        return poem_attributes
    end
end
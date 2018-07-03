require 'nokogiri'
require 'open-uri'
require 'pry'

class EnglishPoetryCorpusGenerator::Scraper
    attr_accessor :browser, :school_modal, :schools_list_node
    URL = "https://www.poetryfoundation.org/poets/browse#page=1&sort_by=last_name"

    def initialize
        @browser = Watir::Browser.start URL
    end

    def scrape_filter_categories
        self.school_modal = @browser.element(:css, "a[aria-controls='school/period']")
        self.school_modal.click

        self.schools_list_node = @browser.ul(class: 'o-compressedList').lis
            
        self.schools_list_node.each do |school|
            EnglishPoetryCorpusGenerator::SchoolPeriod.find_or_create_by_name(school.text)
        end    
    end

    def scrape_filtered_index_page(filter_type, filter)
        case filter_type
        when 'School / Period'
            filter_poems_on_index_page(filter)
            scrape_index_page
            
            #scrape resulting poets
        end

    end

    def filter_poems_on_index_page(filter)
        selected_school = self.schools_list_node.detect {|school| school.text == filter}
        selected_school.click
    end

    def scrape_index_page

        poet_info_nodes = @browser.ol(class: 'c-vList c-vList_bordered c-vList_bordered_thorough').lis
        poet_info_nodes.each do |poet_info_node|

            poet_attribute_hash = {}

            poet_attribute_hash[:name] = poet_info_node.span.text

            poems_node = poet_info_node.ul.lis
            if poems_node
                poet_attribute_hash[:poems] = poems_node.collect do |poem|
                    {:name => poem.text, :link => poem.link.href}
                end
                binding.pry
            end
        end
    end
    
end
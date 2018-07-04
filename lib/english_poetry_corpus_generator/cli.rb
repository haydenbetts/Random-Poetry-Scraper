require 'pry'
require 'watir'
class EnglishPoetryCorpusGenerator::CLI
    attr_accessor :scraper
    def initialize
        self.scraper = EnglishPoetryCorpusGenerator::Scraper.new
    end

    def call
        school_names = self.scraper.scrape_filter_categories
        EnglishPoetryCorpusGenerator::SchoolPeriod.create_schools_by_names(school_names)  
        input = ""

        while input != "Q"

            puts "Welcome to the English Poetry Corpus Generator"
            puts "Select one of the movements below to return 20 poems from that movement"
            puts "To jump between poems, press tab"
            puts "Quit (Q)"

            list_schools
        end
    end

    def list_schools

        EnglishPoetryCorpusGenerator::SchoolPeriod.print_all_with_index

        puts "Select which school you would like to return poems from: "
        input = gets.strip.to_i
        
        if input <= EnglishPoetryCorpusGenerator::SchoolPeriod.all.length && input > 0
            school = EnglishPoetryCorpusGenerator::SchoolPeriod.all[input + 1]
            poet_attribute_hashes = self.scraper.scrape_filtered_index_page(school.class.description, school.name)

            poets = EnglishPoetryCorpusGenerator::Poet.initialize_poets(poet_attribute_hashes)
            poets.each do |poet|
                poet.add_poet_attributes({:schools => [school.name]})
            end
        end

    end
end
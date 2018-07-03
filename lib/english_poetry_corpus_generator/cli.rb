require 'pry'
require 'watir'
class EnglishPoetryCorpusGenerator::CLI
    attr_accessor :scraper
    def initialize
        self.scraper = EnglishPoetryCorpusGenerator::Scraper.new
        self.scraper.scrape_filter_categories
    end

    def call
        input = ""

        while input != "Q"

            puts "Display Poets By School / Period (S)"
            puts "Display Poets By Last Name (A-Z):"
            puts ""
            puts "Quit (Q)"

            input = gets.strip

            case input 
            when "S"
                list_schools
            end
        end
    end

    def list_schools

            EnglishPoetryCorpusGenerator::SchoolPeriod.print_all_with_index

            input = gets.strip.to_i
            
            
            if input <= EnglishPoetryCorpusGenerator::SchoolPeriod.all.length && input > 0
                school_name = EnglishPoetryCorpusGenerator::SchoolPeriod.all[input + 1].name
                self.scraper.scrape_filtered_index_page('School / Period', school_name)
            end
        # array = EnglishPoetryCorpusGenerator::Scraper.new.scrape_index_page
        # EnglishPoetryCorpusGenerator::Poet.initialize_poets(array)
        # binding.pry
    #   Scrape poets starting on page w/ their last name
    #   Instantiate all poets who appear on the
    #   EnglishPoetryCorpusGenerator::Poet.all.print_by_last_name(input)
    #   EnglishPoetryCorpusGenerator::Poet.print_all_with_index

    #   Much harder thing -
    end

    def list_filtered_poems(filter, filter_choice)

    end
end
require 'pry'
require 'watir'
class EnglishPoetryCorpusGenerator::CLI

    def initialize
        url = "https://www.poetryfoundation.org/poets/browse#page=1&sort_by=last_name"
        @b = Watir::Browser.start url
    end

    def call
        input = ""

        while input != "Q"

            puts "Display Poets By School / Period (S)"
            puts "Display Poets By Last Name (A-Z):"
            puts ""
            puts "Quit (Q)"

            input = gets.strip
            list_results(input)
        end
    end

    def list_results(input)
        case input
        when "S"
            # aria-controls="poet's-birthdate"
            @b.element(:css, "a[aria-controls='school/period']").click

            school_ul = @b.ul(class: 'o-compressedList').lis
            
            school_object_array = school_ul.collect do |school|
                EnglishPoetryCorpusGenerator::SchoolPeriod.find_or_create_by_name(school.text)
            end

            EnglishPoetryCorpusGenerator::SchoolPeriod.print_all_with_index

            selection = gets.strip.to_i
            
            if selection <= EnglishPoetryCorpusGenerator::SchoolPeriod.all.length && selection > 0
                # return an 
                # list_filtered_poems(#School or Period => beat)
            end
            
            binding.pry

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

    # e.g. filter = School or Period, filter_choice = Beat
    def list_filtered_poems(filter, filter_choice)

    end
end
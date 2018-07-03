require 'pry'
require 'watir'
class EnglishPoetryCorpusGenerator::CLI

    def initialize
        url = "https://www.poetryfoundation.org/poets/browse#page=1&sort_by=last_name"
        b = Watir::Browser.start url
        b.link(text: "Poet's Birthday").click
        binding.pry
    end

    def call
        input = ""

        while input != "Q"

            puts ""
            puts "Display Poets By Last Name (A-Z):"
            puts ""
            puts "Quit (Q)"

            input = gets.strip
            list_results(input)
        end
    end

    def list_results(input)
        # array = EnglishPoetryCorpusGenerator::Scraper.new.scrape_index_page
        # EnglishPoetryCorpusGenerator::Poet.initialize_poets(array)
        # binding.pry
    #   Scrape poets starting on page w/ their last name
    #   Instantiate all poets who appear on the
    #   EnglishPoetryCorpusGenerator::Poet.all.print_by_last_name(input)
    #   EnglishPoetryCorpusGenerator::Poet.print_all_with_index

    #   Much harder thing -
    end
end
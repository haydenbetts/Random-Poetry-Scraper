require 'pry'

class EnglishPoetryCorpusGenerator::CLI

    def initialize
        page = EnglishPoetryCorpusGenerator::Scraper.initialize_index_page
    end

    def call
        input = ""

        while input != "Q"

            puts ""
            puts "Display Poems by:"
            puts "  Topic (T)"
            puts "  Form (F)"
            puts "  School or Period (S)"
            puts "  Region (R)"
            puts ""
            puts "Quit (Q)"

            input = gets.strip
            list_filter_criteria(input)
        end
    end

    def list_filter_criteria(input)
        case input 
        when 'T'
            # scrape birthdate ranges
            # instantiate a new range for each
            # EnglishPoetryCorpusGenerator::BirthdateRange.print_all_with_index
            # which birthdate range do you want poets from?
            # BirthDateRange.
            # BirthDateRange.find_or_create_poet(region)
            # 
            EnglishPoetryCorpusGenerator::Topic.print_all_with_index
        when 'F'
            EnglishPoetryCorpusGenerator::Form.print_all_with_index
        when 'S'
            EnglishPoetryCorpusGenerator::SchoolOrPeriod.print_all_with_index
        when 'R'
            EnglishPoetryCorpusGenerator::Region.print_all_with_index         
        end
    end
end
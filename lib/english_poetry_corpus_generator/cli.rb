class EnglishPoetryCorpusGenerator::CLI

    def initialize
    end

    def call
        input = ""

        while input != "Q"

            puts ""
            puts "Display Poets by:"
            puts "  Birthdate Range (B)"
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
        when 'B'
            # scrape birthdate ranges
            # instantiate a new range for each
            # EnglishPoetryCorpusGenerator::BirthdateRange.print_all_with_index
            # which birthdate range do you want poets from?
            # BirthDateRange.
            # BirthDateRange.find_or_create_poet(region)
            # 
        when 'S'
            EnglishPoetryCorpusGenerator::SchoolOrPeriod.print_all_with_index
        when 'R'
            EnglishPoetryCorpusGenerator::Region.print_all_with_index         
        end
    end
end
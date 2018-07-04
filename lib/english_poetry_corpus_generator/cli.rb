require 'pry'
require 'trollop'

class CorpusGenerator::CLI
    attr_accessor :current_poems_alphabetized

    def call
        commandline_options = accept_command_line_options

        if commandline_options == {}
            handle_help_message
        else
            if commandline_options[:num_poems] == nil
                handle_no_num_poems_message
            elsif commandline_options[:json] && commandline_options[:pleasure]
                handle_json_and_pleasure_message
            else
                handle_valid_command_line_options(commandline_options)
            end
        end 
    end

    def accept_command_line_options
        opts = Trollop::options do
            version <<-EOS
            📖   English Poetry Corpus Generator
            Version 1.0 | July 2018
            Hayden Betts | @hayden_betts
            EOS

            banner <<~EOS
            \n📖  English Poetry Corpus Generator is a command line gem which returns the text of poems scraped from poemhunter.com.
            \n
            Usage:
            \n
            EOS
          opt :num_poems, "Number of poems to return", :type => :integer    
          opt :json, "Output poems and their attributes directly to json"
          opt :pleasure, "Scrape poems and then enter a CLI for pleasure reading"
        end
        opts.select { |k, v| opts[k] }
    end

    def handle_help_message
        puts ""
        puts "📖  English Poetry Corpus Generator requires you to pass in options indicating" 
        puts "the number of poems you would like to return, and their desired output format." 
        puts "Run with --help for help."
        puts ""
     end

     def handle_json_and_pleasure_message
        puts "Cannot run with both the --json and --pleasure flags selected"
        puts "Run with --help for help."
     end

     def handle_no_num_poems_message
        puts "Cannot run without a --num-poems selected"
        puts "Run with --help for help."
     end

     def handle_valid_command_line_options(commandline_options)
        get_poems(commandline_options[:num_poems])

        if commandline_options[:pleasure]
            pleasure_reading_menu
        elsif commandline_options[:json]
        end

     end

     def get_poems(num_poems)
        num_poems.times do |i|
            poem_attributes = CorpusGenerator::Scraper.new.scrape_poem_page

            # TODO possibly factor out?
            if poem = CorpusGenerator::Poem.new(poem_attributes)
                puts "#{i + 1} poem(s) fetched succesfully."
            else 
                puts "Failed. Trying again."
                i -= 1
            end
        end
     end

    ##
    # => The pleasure reading interface
    ##

    def pleasure_reading_menu
        puts pleasure_reading_header

        puts "How would you like to find poems to read?"
        puts "List poems alphabetically (poems)"
        puts "List poets alphabetically (poets)"
		puts "Or type exit to end the program."

        get_pleasure_reading_menu_input
    end

    def pleasure_reading_header
        File.read('./fixtures/pleasure_reading_header')
    end

    def get_pleasure_reading_menu_input
        input = nil
        input = gets.strip
        case input
        when 'poems'
            poem_selection_instructions
            list_poems_alphabetically
            get_poem_selection
        when 'poets'
        else
            puts "Invalid option!"
        end
    end

    def poem_selection_instructions
        puts "\nType the number of a poem to read it."
		puts "Or type pleasure or p to return the pleasure reading menu."
		puts "Or type exit to end the program."
    end

    def list_poems_alphabetically
        self.current_poems_alphabetized = CorpusGenerator::Poem.all.sort_by {|poem| poem.name}
        self.current_poems_alphabetized.each.with_index(1) do |poem, index|
            puts "#{index}. #{poem.name} - #{poem.poet.name}"
        end
    end

    def get_poem_selection
        input = nil
        input_int = gets.strip.to_i
        
        if input_int > 0 && input_int <= self.current_poems_alphabetized.size
            selected_poem = self.current_poems_alphabetized[input_int - 1]
            display_poem(selected_poem)
        else
            puts "Please enter a valid poem selection!"
        end
    end

    def display_poem(poem)
        puts "#{poem.name} - #{poem.poet.name}"
        puts "\n #{poem.text}"
    end

end
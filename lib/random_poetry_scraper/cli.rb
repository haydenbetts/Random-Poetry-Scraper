class CorpusGenerator::CLI
    attr_accessor :current_poems_alphabetized, :current_poets_alphabetized

    def call(commandline_options = nil)
        
        commandline_options = accept_command_line_options if !commandline_options

        if commandline_options == {}
            handle_no_options_passed_message
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
            📖   Random Poetry Scraper
            Version 1.0 | July 2018
            Hayden Betts | @hayden_betts
            EOS

            banner <<~EOS
            \n📖  Random Poetry Scraper is a command line gem which returns the text of poems scraped from poemhunter.com.
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

    def handle_no_options_passed_message
        puts ""
        puts "📖  Random Poetry Scraper requires you to pass in options indicating" 
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

        if commandline_options[:pleasure]
            get_poems_with_status_updates(commandline_options[:num_poems])
            pleasure_reading_menu
        elsif commandline_options[:json]
            get_poems_without_status_updates(commandline_options[:num_poems])
            json = CorpusGenerator::Poem.poems_to_json(self.current_poems_alphabetized)
            puts json
            return json
        end

     end

     def get_poems_with_status_updates(num_poems)
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

        set_current_poems_alphabetically

     end

     def get_poems_without_status_updates(num_poems)
        num_poems.times do |i|
            poem_attributes = CorpusGenerator::Scraper.new.scrape_poem_page

            # TODO possibly factor out?
            if poem = CorpusGenerator::Poem.new(poem_attributes)
                next
            else 
                i -= 1
            end
        end

        set_current_poems_alphabetically

     end

    def set_current_poems_alphabetically
        self.current_poems_alphabetized = CorpusGenerator::Poem.all.sort_by {|poem| poem.name}
    end

    ##
    # => Function to facilitate returning JSON directly
    ##

    ##
    # => The pleasure reading interface
    ##

    def pleasure_reading_menu
        input = nil

        until input == 'exit'

            pleasure_reading_menu_instructions
            input = gets.strip
            
            case input
            when 'poems'
                poem_selection_menu  
            when 'poets'
                poet_selection_menu
            when 'exit'
                goodbye
            else
                puts "Invalid input! Please select a valid option!"
            end
        end
    end

    def poem_selection_menu(poet = nil)
        input = nil

        while input != 'menu'

            poem_selection_instructions
            list_current_poems

            input = gets.strip
            input_valid = input.to_i > 0 && input.to_i <= self.current_poems_alphabetized.size
 
            if input_valid
                selected_poem = self.current_poems_alphabetized[input.to_i - 1]
                display_poem(selected_poem)
                quit_or_continue_reading
                next
            elsif input == 'exit'
                goodbye
            elsif input != 'menu'
                puts "Please enter a valid poem selection!"
            end
        end
    end

    def poet_selection_menu
        input = nil

        while input != 'menu'

            poet_selection_instructions
            list_poets_alphabetically

            input = gets.strip

            valid_index = input.to_i > 0 && input.to_i <= self.current_poets_alphabetized.size

            if valid_index
                selected_poet = self.current_poets_alphabetized[input.to_i - 1]
                set_poems_alphabetically_by_poet(selected_poet)
                poem_selection_menu
            elsif input == 'exit'
                goodbye
            elsif input != 'menu'
                puts "Please enter a valid poet selection!"
            end

            puts "To return to the poet selection menu, enter 'menu'"
        end
    end

    ##
    # => Pleasure Reading Interface General Helpers
    ##

    def pleasure_reading_menu_instructions
        puts pleasure_reading_header

        puts "How would you like to find poems to read?"
        puts "To see a list of poems, type 'poems', and press enter."
        puts "To see a list of poets, type 'poets', and press enter."
        puts "To end the program, type 'exit', and press enter."
        puts ""
    end

    def pleasure_reading_header
        header_path = File.join( File.dirname(__FILE__), './pleasure_reading_header' )

        File.read(header_path)
    end

    def poem_selection_instructions
        puts "\nType the number of a poem to read it."
		puts "Or type menu to go up one menu."
        puts "Or type exit to end the program."
        puts ""
    end

    def goodbye
		puts "Thanks for using Pleasure reader!"
		exit
    end
    

    ##
    # => Pleasure Reading Interface Poem Selection Menu Helpers
    ##

    def list_current_poems
        self.current_poems_alphabetized.each.with_index(1) do |poem, index|
            puts "#{index}. #{poem.name} - #{poem.poet.name}"
        end
        puts ""
    end

    def display_poem(poem)

        title_string = "#{poem.name} - #{poem.poet.name}"

        puts ""
        puts Array.new(title_string.length, "*").join('')
        puts title_string
        puts Array.new(title_string.length, "*").join('') 
        puts ""
        puts "\n#{poem.text}"
        puts ""
        puts Array.new(title_string.length, "*").join('') 

    end

    def quit_or_continue_reading
        puts ""
        puts "To exit now, type exit"
        puts "To return to the list of poems, press enter"
        puts ""

        input = nil
        input = gets.strip
        goodbye if input == 'exit'
    end

    ##
    # => Pleasure Reading Interface Poet Selection Menu Helpers
    ##

    def poet_selection_instructions
        puts ""
        puts "Type the number of a poet whose poems you would like to read."
		puts "Or type menu to go up one menu."
        puts "Or type exit to end the program."
        puts ""
    end

    def list_poets_alphabetically
        self.current_poets_alphabetized = CorpusGenerator::Poet.all.sort_by {|poet| poet.name}
        self.current_poets_alphabetized.each.with_index(1) do |poet, index|
            puts "#{index}. #{poet.name}"
        end
        puts ""
    end

    def set_poems_alphabetically_by_poet(selected_poet)
        self.current_poems_alphabetized = selected_poet.poems.sort_by {|poem| poem.name}
    end
end
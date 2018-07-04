require 'pry'
require 'trollop'

class CorpusGenerator::CLI

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
            puts 
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
    def pleasure_reading_header
        File.read('./fixtures/pleasure_reading_header')
    end

end
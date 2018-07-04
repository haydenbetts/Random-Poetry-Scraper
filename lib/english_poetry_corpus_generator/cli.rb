require 'pry'
require 'trollop'

class CorpusGenerator::CLI

    def call
        commandline_options = accept_command_line_options

        if commandline_options == []
            handle_help_message
        else
            if !commandline_options.include?(:num_poems)
                handle_no_num_poems_message
            elsif commandline_options.include?(:pleasure) && commandline_options.include?(:json)
                handle_json_and_pleasure_message
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

            banner <<-EOS
            \n📖  English Poetry Corpus Generator is a command line gem which returns the text of poems scraped from poemhunter.com.
            \n
Usage:
            \n
            EOS
          opt :num_poems, "Number of poems to return", :type => :integer    
          opt :json, "Output poems and their attributes directly to json"
          opt :pleasure, "Scrape poems and then enter a CLI for pleasure reading"
        end

        opts.keys.select { |k| opts[k] }
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
end
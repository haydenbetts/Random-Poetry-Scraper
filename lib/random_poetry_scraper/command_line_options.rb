class RandomPoetryScraper::CommandLineOptions

    def self.parse(commandline_options)
        
        commandline_options = trollop_parser if !commandline_options

        if commandline_options == {}
            no_options_passed_message
        else
            if commandline_options[:num_poems] == nil
                no_num_poems_passed_message
            elsif commandline_options[:json] && commandline_options[:pleasure]
                json_and_pleasure_passed_message
            else
                parse_valid(commandline_options)
            end
        end 
    end

    def self.parse_valid(commandline_options)

        if commandline_options[:pleasure]
            return ["pleasure", commandline_options[:num_poems]]
        elsif commandline_options[:json]
            return ["json", commandline_options[:num_poems]]
        end
     end

     def self.trollop_parser
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

    def self.no_options_passed_message
        puts ""
        puts "📖  Random Poetry Scraper requires you to pass in options indicating" 
        puts "the number of poems you would like to return, and their desired output format." 
        puts "Run with --help for help."
        puts ""
     end

     def self.json_and_pleasure_passed_message
        puts "Cannot run with both the --json and --pleasure flags selected"
        puts "Run with --help for help."
     end

     def self.no_num_poems_passed_message
        puts "Cannot run without a --num-poems selected"
        puts "Run with --help for help."
     end

end

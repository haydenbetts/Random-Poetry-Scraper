module EnglishPoetryCorpusGenerator::Concerns
    module Displayable
        def print_all_with_index
            #sort_by
            self.all.each.with_index(1) do |elt, i|
                puts "#{i}. #{elt.name}"
            end
        end
    end
end
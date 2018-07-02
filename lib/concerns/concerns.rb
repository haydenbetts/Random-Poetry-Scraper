module EnglishPoetryCorpusGenerator::Concerns
    module Displayable
        def print_all_with_index
            self.all.each.with_index(1) do |elt, i|
                puts "#{i}. #{elt}"
            end
        end
    end
end
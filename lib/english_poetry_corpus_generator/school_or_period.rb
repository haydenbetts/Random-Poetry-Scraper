require 'pry'

class EnglishPoetryCorpusGenerator::SchoolOrPeriod
    extend EnglishPoetryCorpusGenerator::Concerns::Displayable
    attr_accessor :name

    @@all = [
            "Augustan",
            "Beat",
            "Black Arts Movement",
            "Black Mountain",
            "Confessional"
            ]   

    def initialize(range)
        self.name = range
        self.class.all << self
    end

    def self.all
        @@all
    end

end
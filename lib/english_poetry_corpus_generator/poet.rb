require 'pry'

class EnglishPoetryCorpusGenerator::Poet
    extend EnglishPoetryCorpusGenerator::Concerns::Displayable
    attr_accessor :name

    @@all = [
            "Marjorie Agosín",
            "Jack Agüeros",
            "Leslie Ahlstrand",
            "Dilruba Ahmed",
            "Zubair Ahmed",
            ]   

    def initialize(range)
        self.name = range
        self.class.all << self
    end

    def self.all
        @@all
    end

end
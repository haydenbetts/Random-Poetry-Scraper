class EnglishPoetryCorpusGenerator::BirthdateRange
    extend EnglishPoetryCorpusGenerator::Concerns::Displayable
    attr_accessor :range

    @@all = ["Pre-1600",
            "1600-1699",
            "1700-1799",
            "1800-1899",
            "1900-1950",
             "1951-Present"]

    def initialize(range)
        self.range = range
        self.class.all << self
    end

    def self.all
        @@all
    end
end
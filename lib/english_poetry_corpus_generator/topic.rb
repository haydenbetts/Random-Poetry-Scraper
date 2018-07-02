class EnglishPoetryCorpusGenerator::Topic
    extend EnglishPoetryCorpusGenerator::Concerns::Displayable
    attr_accessor :name

    @@all = ["Love",
            "Nature",
            "Social Commentaries",
            "Religion",
            "Living",
            "Relationships"]

    def initialize(name)
        self.name = name
        self.class.all << self
    end

    def self.all
        @@all
    end
end
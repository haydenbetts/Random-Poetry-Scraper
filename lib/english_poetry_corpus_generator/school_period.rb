class EnglishPoetryCorpusGenerator::SchoolPeriod
    extend EnglishPoetryCorpusGenerator::Concerns::Displayable
    attr_accessor :name

    @@all = []

    def initialize(name)
        self.name = name
        self.class.all << self
    end

    def self.find_or_create_by_name(name)
        if matching_school = self.all.detect {|school| school.name == name }
            matching_school
        else
            EnglishPoetryCorpusGenerator::SchoolPeriod.new(name)
        end
    end

    def self.all
        @@all
    end
end
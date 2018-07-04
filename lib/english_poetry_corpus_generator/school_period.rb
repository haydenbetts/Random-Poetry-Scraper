class EnglishPoetryCorpusGenerator::SchoolPeriod
    extend EnglishPoetryCorpusGenerator::Concerns::Displayable
    attr_accessor :name, :poets

    @@description = "School / Period"
    @@all = []

    def initialize(name)
        self.name = name
        self.class.all << self
        self.poets = []
    end

    def self.find_or_create_by_name(name)
        if matching_school = self.all.detect {|school| school.name == name }
            matching_school
        else
            EnglishPoetryCorpusGenerator::SchoolPeriod.new(name)
        end
    end

    def self.create_schools_by_names(school_names)
        school_names.each do |school_name|
            self.find_or_create_by_name(school_name)
        end
    end

    def self.all
        @@all
    end

    def self.description
        @@description
    end
end
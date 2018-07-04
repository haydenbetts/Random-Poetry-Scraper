require 'pry'

class EnglishPoetryCorpusGenerator::Poet
    extend EnglishPoetryCorpusGenerator::Concerns::Displayable
    attr_accessor :name, :home_page, :poems, :schools

    @@all = []   

    def initialize(attributes = nil)
        @poems = []
        @schools = []
        if attributes
            attributes.each do |k,v|
              self.send("#{k}=", v)
            end
        end
        self.class.all << self
    end

    def add_poem(poem)
        poem.poet = self unless poem.poet
        self.poems << poem if poem
    end

    def add_school(school)
        binding.pry
        school.poets << self
        self.schools << school
    end

    # TODO this expects poem hashes to be passed in. Should only accept objects
    def poems=(poems)
        pms = poems.collect do |poem_attributes|
            poem = EnglishPoetryCorpusGenerator::Poem.new(poem_attributes)
            self.add_poem(poem)
        end
    end

    # TODO this expects array of already-create school objects to be passed in
    def schools=(schools)
        schools.collect do |school|
            school = EnglishPoetryCorpusGenerator::SchoolPeriod.find_or_create_by_name(school)
            self.add_school(school)
        end
    end

    def add_poet_attributes(attributes_hash)
        attributes_hash.each {|key, value| self.send(("#{key}="), value)}
    end

    def self.initialize_poets(poets)
        poets.collect do |poet_attributes|
            self.new(poet_attributes)
        end
    end

    def self.all
        @@all
    end

end
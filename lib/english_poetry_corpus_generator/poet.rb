require 'pry'

class EnglishPoetryCorpusGenerator::Poet
    extend EnglishPoetryCorpusGenerator::Concerns::Displayable
    attr_accessor :name, :home_page, :poems

    @@all = []   

    def initialize(attributes = nil)
        @poems = []
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

    def poems=(poems)
        pms = poems.collect do |poem_attributes|
            poem = EnglishPoetryCorpusGenerator::Poem.new(poem_attributes)
            self.add_poem(poem)
        end
    end

    def self.initialize_poets(poets)
        poets.each do |poet_attributes|
            self.new(poet_attributes)
        end
    end

    def self.all
        @@all
    end

end
require 'pry'

class EnglishPoetryCorpusGenerator::Poet
    extend EnglishPoetryCorpusGenerator::Concerns::Displayable
    attr_accessor :name, :home_page, :poems

    @@all = []   

    def initialize(attributes = nil)
        if attributes
            attributes.each do |k,v|
              self.send("#{k}=", v)
            end
        end
        self.class.all << self
    end

    def self.initialize_poets(poets)
        poets.each do |poet|
            EnglishPoetryCorpusGenerator::Poet.new(poet_attributes)
        end
    end

    def self.all
        @@all
    end

end
class EnglishPoetryCorpusGenerator::Poem
    extend EnglishPoetryCorpusGenerator::Concerns::Displayable
    attr_accessor :name, :link, :poet

    @@all = []

    def initialize(attributes)
        if attributes
            attributes.each do |k,v|
              self.send("#{k}=", v)
            end
        end
        self.class.all << self
    end

    def self.all
        @@all
    end

    def self.initialize_poems
        
    end
end
require 'pry'

class CorpusGenerator::Poem
    extend CorpusGenerator::Concerns::Displayable
    attr_accessor :name, :text, :poet

    @@all = []

    # TODO do you actually want to save all poems as soon
    # as you initialize them?

    def initialize(attributes_hash)
        attributes_hash.each do |attribute, value|
            self.send("#{attribute}=", value)
        end
        self.class.all << self
    end

    # this expects that if there is a poet attribute, it will have a name.
    # that might hardcode too much knowledge about the structure of the hash?
    def poet=(poet_attributes)
        poet = CorpusGenerator::Poet.find_or_create_by_name(poet_attributes[:name])
        @poet = poet
        poet.add_poem(self)
    end

    # Class Methods

    def self.all
        @@all
    end
end
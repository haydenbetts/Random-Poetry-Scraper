require 'pry'

class CorpusGenerator::Poet
    attr_accessor :name, :poems, :profile_url

    @@all = []

    def initialize(attributes_hash)

        self.poems = []

        attributes_hash.each do |attribute, value|
            self.send("#{attribute}=", value)
        end
        self.class.all << self
    end

    # Class Methods

    def self.all
        @@all
    end

    def self.find_by_name
        self.all.detect {|poet| poet.name == name}
    end

    def self.create_by_name
        self.new({:name => name})
    end

    def self.find_or_create_by_name(name)
        if poet = self.find_by_name
            return poet
        else
            self.create_by_name(name)
        end
    end
end
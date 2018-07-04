require 'pry'

class CorpusGenerator::Poet
    attr_accessor :name, :poems

    @@all = []

    def initialize
        self.poems = []
    end

    def save
        self.class.all << self
    end

    # Class Methods

    def self.all
        @@all
    end
end
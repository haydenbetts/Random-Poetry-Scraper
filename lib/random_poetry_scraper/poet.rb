class RandomPoetryScraper::Poet
    attr_accessor :name, :profile_url, :poems

    @@all = []

    def initialize(attributes_hash)

        self.poems = []

        attributes_hash.each do |attribute, value|
            self.send("#{attribute}=", value)
        end
        self.class.all << self
    end

    def add_poem(poem)
        self.poems << poem unless self.poems.detect {|poem| poem == self}
    end

    # Class Methods

    def self.all
        @@all
    end

    def self.find_by_name(name)
        self.all.detect {|poet| poet.name == name}
    end


    def self.find_or_create(attributes)
        # TODO assumes that there will be a name attribute in hash
        # ...assumes that a hash will be passed in
        if poet = self.find_by_name(attributes[:name])
            return poet
        else
            self.new(attributes)
        end
    end
end
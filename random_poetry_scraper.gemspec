Gem::Specification.new do |s|
  s.name        = 'random_poetry_scraper'
  s.version     = '0.1.1'
  s.executables << 'random_poetry_scraper'
  s.summary       = %q{Scrape and return a configurable number of random poems from poemhunter.com/}
  s.description   = %q{Random Poetry Scraper is a command line gem which returns the the attributes of a configurable number of poems scraped from poemhunter.com. The gem allows you to consume the poems either through a JSON dump or through a command line "pleasure reading" interface.}
  s.authors     = ["Hayden Betts"]
  s.email       = 'haydenbetts@gmail.com'
  s.files       =  Dir["{lib}/**/*"]
  s.homepage    =
    'https://github.com/haydenbetts/random-poetry-scraper-cli-app'
  s.license       = 'MIT'

  s.add_development_dependency "bundler", "~> 1.16"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "pry"
  s.add_dependency "nokogiri", "~> 1.8.4"
  s.add_dependency "trollop", "~> 2.0"
  s.add_dependency "json", "~> 2.0"
  
end



Gem::Specification.new do |s|
  s.name        = 'english_poetry_corpus_generator'
  s.version     = '0.1.0'
  s.executables << 'english_poetry_corpus_generator'
  s.summary       = %q{Scrape and return poems from https://www.poetryfoundation.org/}
  s.description   = %q{English Poetry Corpus Generator is a command line gem which returns the text of poems scraped from poemhunter.com.}
  s.authors     = ["Hayden Betts"]
  s.email       = 'haydenbetts@gmail.com'
  s.files       =  Dir["{lib}/**/*"]
  s.homepage    =
    'https://github.com/haydenbetts/english-poetry-corpus-generator-cli-app'
  s.license       = 'MIT'

  s.add_development_dependency "bundler", "~> 1.16"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "pry"
  s.add_dependency "nokogiri"
  s.add_dependency "trollop"
  s.add_dependency "json"

  
end


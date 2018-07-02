require "english_poetry_corpus_generator/version"
require "concerns/concerns"
require "english_poetry_corpus_generator/cli"

require "english_poetry_corpus_generator/topic"
require "english_poetry_corpus_generator/region"
require "english_poetry_corpus_generator/form"
require "english_poetry_corpus_generator/school_or_period"
require "english_poetry_corpus_generator/scraper"
#Dir["english_poetry_corpus_generator/*.rb"].each {|file| require file }

require 'pry'
require 'nokogiri'
require 'open-uri'

module CorpusGenerator
  # Your code goes here...
end

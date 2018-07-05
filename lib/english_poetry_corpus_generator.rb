require "english_poetry_corpus_generator/version"
require "concerns/concerns"
require "english_poetry_corpus_generator/cli"

require "english_poetry_corpus_generator/poet"
require "english_poetry_corpus_generator/poem"
require "english_poetry_corpus_generator/scraper"
#Dir["english_poetry_corpus_generator/*.rb"].each {|file| require file }

require 'pry'
require 'nokogiri'
require 'open-uri'
require 'trollop'
require 'json'

module CorpusGenerator
  # Your code goes here...
end

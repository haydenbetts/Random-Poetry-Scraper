# CorpusGenerator

**English Poetry Corpus Generator** is a command line gem which returns a variable number of random poems scraped from poemhunter.com. You can consume the poems as JSON, or read them in your terminal.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'english_poetry_corpus_generator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install english_poetry_corpus_generator
    
## JSON Format

The JSON follows the following structure:

```
{  
   "poems":[  
      {  
         "name":"One Art",
         "text":"The art of losing isn't hard to master; \nso many things seem filled with the intent\nto be lost that their loss is no disaster,\n\nLose something every day. Accept the fluster\nof lost door keys, the hour badly spent.\nThe art of losing isn't hard to master.\n\nThen practice losing farther, losing faster:\nplaces, and names, and where it was you meant\nto travel. None of these will bring disaster.\n\nI lost my mother's watch. And look! my last, or\nnext-to-last, of three loved houses went.\nThe art of losing isn't hard to master.\n\nI lost two cities, lovely ones. And, vaster,\nsome realms I owned, two rivers, a continent.\nI miss them, but it wasn't a disaster.\n\n- Even losing you (the joking voice, a gesture\nI love)    I shan't have lied. It's evident\nthe art of losing's not too hard to master\nthough it may look like (Write it!)    like disaster.",
         "poet":{  
            "name":"Elizabeth Bishop",
            "profile_url":"https://w0.poemhunter.com/elizabeth-bishop/"
         }
      },
      {  
         "name":"Phenomenal Woman",
         "text":"Pretty women wonder where my secret lies.\nI'm not cute or built to suit a fashion model's size\nBut when I start to tell them,\nThey think I'm telling lies.\nI say,\nIt's in the reach of my arms\nThe span of my hips,\nThe stride of my step,\nThe curl of my lips.\nI'm a woman\nPhenomenally.\nPhenomenal woman,\nThat's me.\n\nI walk into a room\nJust as cool as you please,\nAnd to a man,\nThe fellows stand or\nFall down on their knees.\nThen they swarm around me,\nA hive of honey bees.\nI say,\nIt's the fire in my eyes,\nAnd the flash of my teeth,\nThe swing in my waist,\nAnd the joy in my feet.\nI'm a woman\nPhenomenally.\nPhenomenal woman,\nThat's me.\n\nMen themselves have wondered\nWhat they see in me.\nThey try so much\nBut they can't touch\nMy inner mystery.\nWhen I try to show them\nThey say they still can't see.\nI say,\nIt's in the arch of my back,\nThe sun of my smile,\nThe ride of my breasts,\nThe grace of my style.\nI'm a woman\n\nPhenomenally.\nPhenomenal woman,\nThat's me.\n\nNow you understand\nJust why my head's not bowed.\nI don't shout or jump about\nOr have to talk real loud.\nWhen you see me passing\nIt ought to make you proud.\nI say,\nIt's in the click of my heels,\nThe bend of my hair,\nthe palm of my hand,\nThe need of my care,\n'Cause I'm a woman\nPhenomenally.\nPhenomenal woman,\nThat's me.",
         "poet":{  
            "name":"Maya Angelou",
            "profile_url":"https://w0.poemhunter.com/maya-angelou/"
         }
      }
   ]
}
```

**Note**: Newlines are included in the poem text attributes in order to preserve the text's original format.

## Consuming Poem JSON Programmatically

There are two methods for consuming json using this gem.

If you would like to consume the json inside of a ruby program, you can do the following. 

```ruby
require 'english_poetry_corpus_generator'

poems_json = CorpusGenerator::CLI.new.call({:json => true, :num_poems => 2})
```
**Note**: You can set the ```:num_poems``` attribute to any integer of your choosing.

If you would like to consume the json in a standard shell, you can can do the following. This will output the poem json to ```stdout```.

```
english_poetry_corpus_generator --num-poems=2 --json
```

From ```stdout```, you can dump the poem json to a file e.g.

```
english_poetry_corpus_generator --num-poems=2 --json > poems.json
```

## License

The gem was written by [Hayden Betts](https://twitter.com/HaydenBetts). I do not claim any ownership of the poems represented here.

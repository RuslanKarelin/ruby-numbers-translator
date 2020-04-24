# NumbersTranslator

Translating numbers into English

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'numbers_translator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install numbers_translator

## Usage

NumbersTranslator::Translator::make 1560

=> "one thousand five hundred and sixty"

OR

NumbersTranslator::Translator::make 1560, 'usa'

=> "one thousand five hundred sixty"
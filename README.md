# URLAttributes

A small and simple gem for validating URL attributes in your ActiveRecord models.

## Installation

Add the gem to your `Gemfile`

    gem 'url_attributes'

And run `bundle install`.

## Usage

Add a string column to your ActiveRecord model which will contain a url, e.g. `link`,
then call the class method `url_attribute` in your model like this:

    class MyAwesomeModel < ActiveRecord::Base

      url_attribute :link

    end

This does two things:

1. It adds a validation to `link` that 
2. Before save, it strips trailing whitespace from the link and adds
   `"http://"` to the beginning if it (or `"https://"`) is not already there.

If you want the logic to run somewhere other than `before_save`, pass a
`:before` option with the name of another `before_` callback:

    class MyAwesomeModel < ActiveRecord::Base

      url_attribute :link, before: :validation

    end

## Matcher

The gem also comes with an RSpec matcher. You can use it like this:

    describe MyAwesomeModel do

      it { is_expected.to have_url_attribute :link }

    end

## Contributing

Want to contribute to this gem? You're more than welcome! Just clone the repo from GitHub,
upload your changes and open a pull request.

Make sure to add tests for your changes so they don't get accidentally broken by a future update.

(C) 2014 George Millo (Headstock Software)

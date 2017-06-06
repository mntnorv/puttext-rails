# puttext-rails

Rails integrations for the puttext gem (https://github/mntnorv/puttext).

What this provides for Rails applications, compared to the plain Ruby gem:
 - Simplified usage.
 - Extracts validation error messages from Rails validator and all used gems.

## Installation

Add it to your `Gemfile`:
```ruby
group :development do
  # Other development gems
  # ...

  gem 'puttext-rails'
end
```

## Usage

Just run the `puttext:extract` rake task in your Rails root directory:
```bash
$ rake puttext:extract
```

The translations will be saved in `config/locale/template.pot`. For example:
```po
#: ./app/views/hello_world/index.slim:8
msgid "Hello world!"
msgstr ""
```

## Contributing

Before submitting an Issue or Pull Request always check if your issue is already being discussed or if someone has already submitted a pull request with the feature you want to add. Also, before doing bigger changes, it's always good to discuss the changes you're going to make in an Issue.

### Code style

PutText::Rails uses RuboCop (https://github.com/bbatsov/rubocop) to check and enforce code style. Before submitting a pull request, make sure that RuboCop does not find any offenses.

#### Running RuboCop

```bash
$ bundle exec rubocop
```

### Testing

PutText::Rails uses RSpec (http://rspec.info/) for testing. Pull requests with Ruby code changes must include RSpec tests that check the new functionality or changed code. Also, make sure that your changes do not break any existing tests.

#### Running RSpec

```bash
$ bundle exec rspec
```

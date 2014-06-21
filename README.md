# Rail
A light framework for front-end development inspired by
[Rails](http://rubyonrails.org/). It is solely based on
[Sprockets](https://github.com/sstephenson/sprockets) and includes the
following components out of the box:
* [CoffeeScript](http://coffeescript.org/) for JavaScript,
* [Haml](http://haml.info/) for HTML,
* [Sass](http://sass-lang.com/) for CSS, and
* [Uglifier](https://github.com/lautis/uglifier) for compression.

## Installation
First of all, include the gem in your `Gemfile`. Here is an example:
```ruby
source 'https://rubygems.org'

gem 'rail', '~> 0.1.0'

# The rest is optional
gem 'redcarpet', '~> 3.1.2' # your favorit complement to Haml
gem 'thin', '~> 1.6.2'      # your favorit Web server
```

Then run [Bundler](http://bundler.io/):
```bash
$ bundle
```

Now we need to create two files: `config.ru` and `config/application.rb`.
In `config.ru`:
```ruby
require_relative 'config/application'

run MyProject::Application.new
```

In `config/application.rb`:
```ruby
require 'bundler'
Bundler.require(:default)

module MyProject
  class Application < Rail::Application
  end
end
```

Feel free to replace `MyProject` with the name of your project. That’s it.

## Usage
Rail closely follows Rails. If you know Rails, you already know how to use
Rail. Organize your code according to the following convention:
* scripts in `app/assets/javascripts`,
* styles in `app/assets/stylesheets`,
* views in `app/views`, and
* helpers in `app/helpers`.

In addition, `app/views/layouts/application.html.haml` will be used for
rendering the root of your application (both `/` and `/index.html`).

Usage examples can be found [here](https://github.com/IvanUkhov/type-works),
[here](https://github.com/IvanUkhov/photography), and
[here](https://github.com/IvanUkhov/liu-profile).

## Contributing
1. [Fork](https://help.github.com/articles/fork-a-repo) the project.
2. Create a branch for your feature (`git checkout -b awesome-feature`).
3. Implement your feature (`vim`).
4. Commit your changes (`git commit -am 'Implemented an awesome feature'`).
5. Push to the branch (`git push origin awesome-feature`).
6. [Create](https://help.github.com/articles/creating-a-pull-request)
   a new Pull Request.

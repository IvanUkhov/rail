# Rail [![Gem Version](https://badge.fury.io/rb/rail.svg)](http://badge.fury.io/rb/rail) [![Dependency Status](https://gemnasium.com/IvanUkhov/rail.svg)](https://gemnasium.com/IvanUkhov/rail) [![Build Status](https://travis-ci.org/IvanUkhov/rail.svg?branch=master)](https://travis-ci.org/IvanUkhov/rail)

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

gem 'rail', '~> 0.0.5'

# The rest is optional
gem 'redcarpet', '~> 3.1.2' # your favorit complement to Haml
gem 'thin', '~> 1.6.2'      # your favorit Web server
```

Then run [Bundler](http://bundler.io/):

```bash
$ bundle
```

Now we need to create three files: `config/application.rb`, `config.ru`, and
`Rakefile`. In `config/application.rb`:

```ruby
require 'bundler'
Bundler.require(:default)

module MyProject
  class Application < Rail::Application
  end
end
```

In `config.ru`:

```ruby
require_relative 'config/application'

run MyProject::Application.new
```

In `Rakefile`:

```ruby
require_relative 'config/application'

MyProject::Application.load_tasks
```

Feel free to replace `MyProject` with the name of your project. That’s it.

## Usage

Rail closely follows Rails. If you know Rails, you already know Rail.

### Structure

Organize your code according to the following convention:

* `app/assets/javascripts` for scripts,
* `app/assets/stylesheets` for styles,
* `app/views` for templates,
* `app/helpers` for helper modules, and
* `public` for other static content.

In addition, `app/views/layouts/application.html.haml` will be used for
rendering the root of your application (both `/` and `/index.html`).

### Configuration

As with Rails, Rail is configured inside `config/application.rb`:

```ruby
module MyProject
  class Application < Rail::Application
    # Import assets from other gems:
    config.gems << 'turbolinks'

    # Precompile assets using `rake assets`:
    config.precompile << 'application.css'
    config.precompile << 'application.js'
    config.precompile << 'index.html'

    # Compress assets:
    config.compress = true
  end
end
```

If `config.compress` is not specified, it is implicitly set to
`ENV['RAIL_ENV'] == 'production'`.

### Commands

Run [Rake](https://github.com/jimweirich/rake) to see the available tasks:

```bash
$ rake -T
rake assets  # Precompile assets
rake server  # Start server
```

`rake server` starts up a Web server; if none is specified in `Gemfile`,
[WEBrick](http://ruby-doc.org/stdlib-2.1.2/libdoc/webrick/rdoc/WEBrick.html)
will be fired up.

`rake assets` compiles your assets and stores them in `public`. You should
explicitly tell Rail what to compile as it was shown in the previous section.
Note that the server will try to serve from `public` first, so make sure you
delete the precompiled files when you change your code in `app`.

### Examples

Additional usage examples can be found
[here](https://github.com/IvanUkhov/type-works),
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

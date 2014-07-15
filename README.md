# Rail [![Gem Version](https://badge.fury.io/rb/rail.svg)](http://badge.fury.io/rb/rail) [![Dependency Status](https://gemnasium.com/IvanUkhov/rail.svg)](https://gemnasium.com/IvanUkhov/rail) [![Build Status](https://travis-ci.org/IvanUkhov/rail.svg?branch=master)](https://travis-ci.org/IvanUkhov/rail)

A light framework for front-end development inspired by
[Rails](http://rubyonrails.org/). The sole purpose of Rail is to compile
assets, and it includes the following components:

* [CoffeeScript](http://coffeescript.org/) for JavaScript,
* [Haml](http://haml.info/) for HTML, and
* [Sass](http://sass-lang.com/) for CSS.

## Installation

### Straightforward

Install the gem:

```bash
$ gem install rail
```

Create a new project:

```bash
$ rail new my_project
```

Run [Bundler](http://bundler.io/):

```bash
$ cd ./my_project
$ bundle
```

Run the server:

```bash
$ rake server
```

Open `http://localhost:3000` in your browser, see “My Project,” and enjoy.

Under the hood, the `rail new my_project` command creates a new folder in the
current directory called `my_project` and initializes a basic Rail project
inside that folder. In this case, `MyProject` is used as the class name of
the project. Feel free to replace `my_project` with the name of your project.

### Manual

Include the gem in your `Gemfile`:

```ruby
source 'https://rubygems.org'

gem 'rail', '~> 0.0.7'

# The rest is optional
gem 'redcarpet', '~> 3.1.2' # your favorit complement to Haml
gem 'thin', '~> 1.6.2'      # your favorit Web server
```

Run [Bundler](http://bundler.io/):

```bash
$ bundle
```

Create three files: `config/application.rb`, `config.ru`, and `Rakefile`.
In `config/application.rb`:

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

Feel free to replace `MyProject` with the name of your project.

## Usage

Rail closely follows Rails. If you know Rails, you already know Rail.

### Structure

Organize your code according to the following convention:

* `app/assets/javascripts` for scripts,
* `app/assets/stylesheets` for styles,
* `app/views` for templates,
* `app/helpers` for helper modules, and
* `public` for other static content.

The templates in `app/views/layouts` have a special purpose. First,
`application.html.haml` is used for rendering the root of your application
(both `/` and `/index.html`). Second, any template in `layouts` is used as
a layout for the templates in the subfolder of `views` that has the same name
as the layout. For example, `articles/what-is-the-meaning-of-life.html.haml`
will be rendered in the context of `layouts/articles.html.haml` provided
that the latter has a placeholder for the former via the `yield` keyword.

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
[here](https://github.com/IvanUkhov/opentype-works),
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

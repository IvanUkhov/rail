# Rail [![Version][version-img]][version-url] [![Dependency Status][depend-img]][depend-url] [![Build Status][build-img]][build-url]

A light framework for front-end development inspired by [Rails][rails]. The sole
purpose of Rail is to compile assets, and it includes the following components:

* [CoffeeScript][coffeescript] for JavaScript,
* [Haml][haml] for HTML, and
* [Sass][sass] for CSS.

## Installation

### Straightforward

Install the gem:

```bash
gem install rail
```

Create a new project:

```bash
rail new my_project
```

Run [Bundler][bundler]:

```bash
cd ./my_project
bundle
```

Run the server:

```bash
rake server
```

Open `http://localhost:3000` in your browser, see “My Project,” and enjoy.

Under the hood, the `rail new my_project` command creates a new folder in the
current directory called `my_project` and initializes a basic Rail project
inside that folder. In this case, `MyProject` is used as the class name of the
project. Feel free to replace `my_project` with the name of your project.

### Manual

Create a `Gemfile`:

```ruby
source 'https://rubygems.org'

gem 'rail'
```

Run [Bundler][bundler]:

```bash
bundle
```

Create three files: `config/application.rb`, `config.ru`, and `Rakefile`. In
`config/application.rb`:

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
`application.html.haml` is used for rendering the root of your application (both
`/` and `/index.html`). Second, any template in `layouts` is used as a layout
for the templates in the subfolder of `views` that has the same name as the
layout. For example, `articles/what-is-the-meaning-of-life.html.haml` will be
rendered in the context of `layouts/articles.html.haml` provided that the latter
has a placeholder for the former via the `yield` keyword.

### Configuration

As with Rails, Rail is configured inside `config/application.rb`:

```ruby
module MyProject
  class Application < Rail::Application
    # Gems to look for additional assets
    config.gems << 'googleplus-reader'

    # Assets to precompile when running `rake assets`
    config.precompile << 'application.css'
    config.precompile << 'application.js'
    config.precompile << 'index.html'

    # Compress assets when serving and precompiling
    config.compress = true
  end
end
```

If `config.compress` is not specified, it is implicitly set to `ENV['RAIL_ENV']
== 'production'`.

### Commands

Run [Rake][rake] to see the available tasks:

```bash
rake -T
rake assets  # Precompile assets
rake server  # Start server
```

`rake server` starts up a Web server; if none is specified in `Gemfile`,
[WEBrick][webrick] will be fired up.

`rake assets` compiles your assets and stores them in `public`. You should
explicitly tell Rail what to compile as it was shown in the previous section.
Note that the server will try to serve from `public` first, so make sure you
delete the precompiled files when you change your code in `app`.

### Examples

Additional usage examples can be found
[here](https://github.com/IvanUkhov/opentype),
[here](https://github.com/IvanUkhov/photography), and
[here](https://github.com/IvanUkhov/research).

## Contribution

1. Fork the project.
2. Implement your idea.
3. Open a pull request.

[build-img]: https://travis-ci.org/IvanUkhov/rail.svg?branch=master
[build-url]: https://travis-ci.org/IvanUkhov/rail
[depend-img]: https://gemnasium.com/IvanUkhov/rail.svg
[depend-url]: https://gemnasium.com/IvanUkhov/rail
[version-img]: https://badge.fury.io/rb/rail.svg
[version-url]: https://badge.fury.io/rb/rail

[bundler]: http://bundler.io
[coffeescript]: http://coffeescript.org
[haml]: http://haml.info
[rails]: http://rubyonrails.org
[rake]: https://github.com/ruby/rake
[sass]: http://sass-lang.com
[webrick]: http://ruby-doc.org/stdlib-2.1.2/libdoc/webrick/rdoc/WEBrick.html

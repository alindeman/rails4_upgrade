# rails4\_upgrade [![Build Status](https://secure.travis-ci.org/alindeman/rails4_upgrade.png?branch=master)](http://travis-ci.org/alindeman/rails4_upgrade)

Helps you more easily upgrade to Rails 4. A work in progress, I'm simply
shipping something of a minimum viable product to attract others to
contribute.

Inspired by [rails_upgrade](https://github.com/rails/rails_upgrade) which
helped upgrade applications from Rails 2 to Rails 3.

## Installation

Upgrade to Ruby 1.9.3 if your application does not already use it. Rails 4
requires Ruby 1.9.3, and `rails4_upgrade` uses 1.9-only syntax and semantics.

Add to `Gemfile`:

```ruby
gem 'rails4_upgrade', github: 'alindeman/rails4_upgrade'
```

## Usage

Run `rake rails4:check`:

```
$ rake rails4:check

** GEM COMPATIBILITY CHECK **
+--------------------+----------------------+
| Dependency Path    | Rails Requirement    |
+--------------------+----------------------+
| draper 0.18.0      | actionpack ~> 3.2    |
| draper 0.18.0      | activesupport ~> 3.2 |
| simple_form 2.0.4  | actionpack ~> 3.0    |
| simple_form 2.0.4  | activemodel ~> 3.0   |
+--------------------+----------------------+
```

## Contributing

I'm open to accepting pull requests that improve the functionality of the gem.

If there's an upgrade procedure that can be automated or semi-automated, let's
discuss it. Open an
[issue](https://github.com/alindeman/rails4_upgrade/issues).

Ideas:

* Recommending versions of gems that may be compatible with Rails 4
* Removing deprecated configuration options
* Adding newly required or recommended configuration options

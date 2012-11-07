# CrappyCounter

Gem that just builds up a load of counters in Redis.

## Installation

Add this line to your application's Gemfile:

    gem 'crappycounter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crappycounter

## Usage

This gem assumes you have Redis availble on a global var called `$redis`.

On an app I wanted to update stats with simple date filters so that I could easily 
aggregate counts for day year month, but the more states the more of a pain it was:

```
my_key
my_key:2001
my_key:200112
my_key:20011231
my_key:some_state
my_key:some_state:2001
my_key:some_state:200112
my_key:some_state:20011231
```

CrappyCounter simply takes an array of key (with an optional date) and increments them all for you:

```
CrappyCounter.incr keys: ["my_key", "some_state"], date: today
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

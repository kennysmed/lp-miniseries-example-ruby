# Little Printer Miniseries Example (Ruby)

This is an example publication, written in Ruby with the [Sinatra framework](http://www.sinatrarb.com/). The same example can also be seen in:

* [PHP](https://github.com/bergcloud/lp-miniseries-example-php)
* [Python](https://github.com/bergcloud/lp-miniseries-example-python)

The working publication (using the Ruby code) can be subscribed to [on BERG Cloud Remote](http://remote.bergcloud.com/publications/335).

The publication will deliver a new image to your Little Printer every weekday for 174 days, from [the 1658 book](http://digital.lib.uh.edu/collection/p15195coll18) <cite>The History of Four-Footed Beasts and Serpents</cite>.

## Run it

Run the server with:

    $ bundle exec ruby publication.rb

You can then visit these URLs:

* `/edition/?delivery_count=0&local_delivery_time=2013-10-21T19:20:30+01:00`
* `/icon.png`
* `/meta.json`
* `/sample/`

Change the value of `delivery_count` in the call to `/edition/` to see other editions.

You can also try these URLs on the live example of the publication at http://lp-miniseries-example-ruby.herokuapp.com/ .

----

BERG Cloud Developer documentation: http://remote.bergcloud.com/developers/


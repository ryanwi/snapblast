# SnapBlast

Instantly broadcast a phone message to your TeamSnap team. SnapBlast was created
by <a href="http://www.ryan-williams.net">Ryan Williams</a>
(<a href="https://twitter.com/ryanwi">@ryanwi</a>).

## Why?

[TeamSnap](http://www.teamsnap.com/) offers features for sending emails and SMS
messages, but not voice calls.

SnapBlast allows a coach/manager to quickly call the entire team in one blast
with a voice message.  For when you need to get word out in a hurry.

Primarily a personal development project, but feel free to use.

## Features

- Login with your TeamSnap credentials
- Choose one of your teams to call
- Write a message and send it, it will be converted to voice and all players will be a call.

## Built With

SnapBlast is built usint these open source components:

- [Ruby on Rails 4](https://github.com/rails/rails)
- [TeamSnap API](https://api.teamsnap.com/v2/)
- [Twilio API](https://www.twilio.com/)
- [Bootstrap 3](http://getbootstrap.com/)
- [RVM](http://rvm.io/)
- [faraday](https://github.com/lostisland/faraday)
- [RSpec](https://github.com/rspec/rspec)
- [figaro](https://github.com/laserlemon/figaro)

## Development Setup

To check out the code more closely or run the app, first clone this repository:

```bash
git clone git@github.com:ryanwi/snapblast.git

cd snapblast

# Create a gemset
rvm use 2.0@snapblast --create

# Install gems
gem install bundler
bundle

# Prepare configuration
cp config/database.yml.example config/database.yml
cp config/application.yml.example config/application.yml

# Get a new secret token
rake secret

# Update config/appliation.yml with secret and keys

rails s
```

## Author

**Ryan Williams**

- <http://www.ryan-williams.net>
- <https://twitter.com/ryanwi>
- <https://github.com/ryanwi>



non-trial account/balance
tests/rspec
new relic/keeping site up

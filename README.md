# CampPlaner [![Circle CI](https://circleci.com/gh/dev-kitchen/campbuddy.svg?style=svg)](https://circleci.com/gh/dev-kitchen/campbuddy)

For camps, you know.


## Setup

```bash
bundle install
rake db:create db:schema:load db:seed
```

## Development

```bash
rails server
```

Go to http://devel.example.org.127.0.0.1.xip.io:3000/ .

## Deployment

```bash
eval $(ssh-agent)
ssh-add
cap production deploy
```

## Send Welcome Mail

### Writing

Available Variables:

* `{{firstname}}` replaced by the firstname of the user
* `{{invitation_url}}` replaced by the invite url to get the user started

### Sending

```ruby
Apartment::Tenant.switch 'tenant'
ActionMailer::Base.default_url_options = { host: 'tenant.host' }
User.find_each(&:send_welcome_mail)
```

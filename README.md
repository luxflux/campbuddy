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

## Setup a new Tenant

```ruby
attributes = {
  name: '20er Summercamp 2017',
  subdomain: '20er-summer2017',
  starts: '2017-09-02',
  ends: '2017-09-09',
  hashtag: 'zwzgrsummercamp',
  allow_sign_up: false,
  welcome_mail: Camp.find(5).welcome_mail,
  welcome_text: 'Welcome',
  reply_to: 'buddy@campbuddy.ch',
  registration_opens: '2017-09-02',
}
camp = Organization.find(2).camps.create! attributes
Apartment::Tenant.switch camp.schema_name
User.create! email: 'raffael@yux.ch', firstname: 'Raffael', name: 'Schmid', password: 'passwordhere', admin: true
```

## Send Welcome Mail

### Writing

Available Variables:

* `{{firstname}}` replaced by the firstname of the user
* `{{invitation_url}}` replaced by the invite url to get the user started

### Sending

```ruby
Apartment::Tenant.switch! 'tenant'
ActionMailer::Base.default_url_options = { host: 'tenant.host' }
User.real_users.find_each(&:send_welcome_mail)
```

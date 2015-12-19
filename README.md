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

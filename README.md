# CampPlaner [![Build Status](https://semaphoreapp.com/api/v1/projects/8ce7c695-b8dc-4057-ba67-d6e0d25e6f0c/292344/badge.png)](https://semaphoreapp.com/luxflux/camp-workshops)

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

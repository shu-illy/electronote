#!/bin/sh

if [ "${RAILS_ENV}" = "production" ]
then
  bundle exec rails assets:precompile
fi

echo docker image updated at 20210216


FROM ruby:3.0.2

ADD https://dl.yarnpkg.com/debian/pubkey.gpg /tmp/yarn-pubkey.gpg
RUN apt-key add /tmp/yarn-pubkey.gpg && rm /tmp/yarn-pubkey.gpg
RUN echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn build-essential libpq-dev
RUN apt-get install -y libxml2-dev libxslt1-dev

## Create folder developer
RUN mkdir -p /home/developer
## Set folder
WORKDIR /home
## Create folder app
RUN mkdir -p /home/developer/app
## User folder app
WORKDIR /home/developer/app
## Copy file
COPY ./Gemfile .
COPY ./Gemfile.lock .
## Install gems
RUN bundle install
## Create folder entrypoint
RUN mkdir -p /home/developer/app/entrypoints
## Add entrypoint file
ADD ./entrypoints/docker-entrypoint.sh /home/developer/app/entrypoints
## Copy the main app
COPY ./ .
## Expose PORT 3000
EXPOSE 3000
## Giving permissions to entrypoint
RUN ["chmod", "+x", "/home/developer/app/entrypoints/docker-entrypoint.sh"]
## Run server
ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
#ENTRYPOINT ["bin/rails"]
#CMD ["s", "-b", "0.0.0.0"]
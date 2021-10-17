FROM ruby:2.6.6

# RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/list/*
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

RUN apt-get install -y postgresql-client --no-install-recommends && rm -rf /var/lib/apt/list/*
RUN apt-get install -y build-essential libpq-dev

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install --no-install-recommends yarn

WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN gem install bundler -v 2.1.4
RUN bundle install

COPY . /myapp

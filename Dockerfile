FROM ruby:2.5.3 as Dependencies

RUN apt-get update
RUN apt-get install --assume-yes \
	git-core zlib1g-dev \
	build-essential libssl-dev \
	libreadline-dev libyaml-dev \
	libsqlite3-dev sqlite3 \
	libxml2-dev libxslt1-dev \
	libcurl4-openssl-dev \
	software-properties-common \
	libffi-dev nodejs yarn \
	libpq-dev postgresql \
	libsodium-dev

RUN useradd -rm -d /home/ruby -s /bin/bash -g root -G sudo -u 1001 ruby
USER ruby
WORKDIR /home/ruby

RUN mkdir -p /home/ruby/www

RUN gem install nokogiri -v 1.12.5
RUN gem install debase -v 0.2.4.1
RUN gem install rake -v 13.0.3
RUN gem install rubocop -v 0.58.0
RUN gem install solargraph

FROM ubuntu:bionic as OS
ENV NODE_VERSION=12
ENV RUBY_VERSION=2.5.3
ENV GEM_PATH="/usr/local/rvm/gems/ruby-${RUBY_VERSION}"
ENV PATH="/home/vscode/.rvm/bin:/usr/local/bundle/bin:${PATH}" \
	PATH="/usr/local/rvm/rubies/default/bin:/usr/local/rvm/gems/default@global/bin:/usr/local/rvm/rubies/default/bin:/usr/local/rvm/bin:${PATH}"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install --assume-yes curl git-core \
	zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev \
	sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common \
	libffi-dev postgresql libpq-dev

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION} --lts
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

RUN curl -sSL https://get.rvm.io | bash
RUN rvm install ${RUBY_VERSION}
RUN rvm use ${RUBY_VERSION} --default
RUN rvm alias create default ${RUBY_VERSION}
RUN gem install nokogiri -v 1.12.5
RUN gem install debase -v 0.2.4.1
RUN gem install rake -v 13.0.3
RUN gem install rubocop -v 0.58.0
RUN gem install rails -v 5.2.5
RUN gem install solargraph

RUN mkdir -p /var/www

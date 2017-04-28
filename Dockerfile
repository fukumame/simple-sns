FROM ruby:2.3.1
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" >> /etc/apt/sources.list.d/pgdg.list && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
  apt-get update -qq && \
  curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
  apt-get install -y nodejs postgresql-client-9.4 \
  less fonts-vlgothic # for testing

RUN echo "deb http://packages.groonga.org/debian/ jessie main" >> /etc/apt/sources.list.d/groonga.list && \
  echo "deb-src http://packages.groonga.org/debian/ jessie main" >> /etc/apt/sources.list.d/groonga.list && \
  apt-get update -qq && \
  apt-get install -y --allow-unauthenticated groonga-keyring && \
  apt-get update -qq && \
  apt-get install -y --force-yes groonga groonga-tokenizer-mecab libgroonga-dev

RUN apt-get update -qq && \
  apt-get install -y build-essential chrpath libssl-dev libxft-dev && \
  apt-get install -y libfreetype6 libfreetype6-dev && \
  apt-get install -y libfontconfig1 libfontconfig1-dev && \
  cd /tmp && \
  export PHANTOM_JS="phantomjs-2.1.1-linux-x86_64" && \
  wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 && \
  tar xvjf $PHANTOM_JS.tar.bz2 && \
  mv $PHANTOM_JS /usr/local/share && \
  ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

RUN echo 'alias be="bundle exec"' >> ~/.bashrc

RUN echo " \n\
if defined?(PryByebug) \n\
  Pry.commands.alias_command 's', 'step' \n\
  Pry.commands.alias_command 'n', 'next' \n\
  Pry.commands.alias_command 'f', 'finish' \n\
  Pry.commands.alias_command 'c', 'continue' \n\
end" >> ~/.pryrc

ENV BUNDLE_PATH=/app/vendor/bundle \
  BUNDLE_JOBS=4 \
  RAILS_LOG_TO_STDOUT=enabled \
  RAILS_SERVE_STATIC_FILES=enabled \
  LANG=C.UTF-8 \
  LC_ALL=C.UTF-8

WORKDIR app
#CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "80"]

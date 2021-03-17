FROM ruby:2.7


RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn build-essential imagemagick \
  && yarn add jquery@3.4.1 bootstrap@3.4.1
WORKDIR /electronote
COPY Gemfile Gemfile.lock package.json yarn.lock /electronote/

COPY . /electronote

# RUN bundle config set path './vendor/bundle' && \
#     bundle install

RUN bundle install

# COPY . /electronote

# *.sockを配置するディレクトリを作成
RUN rm -rf /electronote/tmp/*
RUN mkdir -p /electronote/tmp/sockets
RUN mkdir -p /electronote/tmp/pids

# COPY start.sh /start.sh
RUN chmod 744 /electronote/start.sh
CMD ["sh", "/electronote/start.sh"]

EXPOSE 3000

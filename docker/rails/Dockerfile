FROM ruby:2.7


RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn build-essential
WORKDIR /electronote
COPY . /electronote

# RUN bundle config --local set path 'vendor/bundle' && \
#     bundle install

RUN bundle install

# *.sockを配置するディレクトリを作成
RUN rm -rf /electronote/tmp/*
RUN mkdir -p /electronote/tmp/sockets
RUN mkdir -p /electronote/tmp/pids

COPY start.sh /start.sh
RUN chmod 744 /start.sh
CMD ["sh", "/start.sh"]

EXPOSE 3000

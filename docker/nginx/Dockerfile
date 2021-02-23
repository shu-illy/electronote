FROM nginx:1.16

RUN apt-get update && \
    apt-get install -y apt-utils \
    locales && \
    echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8

WORKDIR /electronote

# インクルード用のディレクトリ内を削除
RUN rm -f /etc/nginx/conf.d/*


# Nginxの設定ファイルをコンテナにコピー
ADD ./docker/nginx/nginx.conf /etc/nginx/nginx.conf
ADD ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf
# ADD ./docker/nginx/index.html /index.html
# COPY ../public/index.html /app/public/index.html

# ビルド完了後にNginxを起動
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf

EXPOSE 80

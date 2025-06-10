# Dockerfile

# RUBY_VERSIONが.ruby-versionとGemfileのバージョンと一致していることを確認
ARG RUBY_VERSION=3.4.4
FROM ruby:$RUBY_VERSION

# ↓ RUN命令を2つに分割します

# 最初に、これまで通りのパッケージをインストール
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git curl sqlite3

# 次に、libvips-devだけを独立してインストール
RUN apt-get install -y libvips-dev

# Railsアプリケーションはここに配置
WORKDIR /rails

# bundle installを実行
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションコードをコピー
COPY . .

# デフォルトでサーバーを起動、実行時に上書き可能
EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]